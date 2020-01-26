{-# LINE 1 "src/Tesseract/Bindings.hsc" #-}
{-# LANGUAGE CPP, ForeignFunctionInterface #-}
module Tesseract (
    -- | Enumerations
     OcrEngineMode
    ,PageSegMode
    ,PageIteratorLevel
    ,PolyBlockType
    ,Orientation
    ,ParagraphJustification
    ,WritingDirection
    ,TextlineOrder

    -- | Structs

    -- | Functions
    ,c_tesseract_version
) where

import Protolude

import Foreign
import Foreign.C.String
import Foreign.C.Types



-----------------------------
--
--      Enumerations
--
-----------------------------

newtype OcrEngineMode = OcrEngineMode { unEngineMode :: Int }
    deriving (Eq, Show)

tesseract_only  :: OcrEngineMode
tesseract_only  = OcrEngineMode 0
lstm_only  :: OcrEngineMode
lstm_only  = OcrEngineMode 1
tesseract_lstm_combined  :: OcrEngineMode
tesseract_lstm_combined  = OcrEngineMode 2
oem_default  :: OcrEngineMode
oem_default  = OcrEngineMode 3

{-# LINE 42 "src/Tesseract/Bindings.hsc" #-}

newtype PageSegMode = PageSegMode { unPageSegMode :: Int }
    deriving (Eq, Show)

psm_osd_only  :: PageSegMode
psm_osd_only  = PageSegMode 0
psm_auto_osd  :: PageSegMode
psm_auto_osd  = PageSegMode 1
psm_auto_only  :: PageSegMode
psm_auto_only  = PageSegMode 2
psm_auto  :: PageSegMode
psm_auto  = PageSegMode 3
psm_single_column  :: PageSegMode
psm_single_column  = PageSegMode 4
psm_single_block_vert_text  :: PageSegMode
psm_single_block_vert_text  = PageSegMode 5
psm_single_block  :: PageSegMode
psm_single_block  = PageSegMode 6
psm_single_line  :: PageSegMode
psm_single_line  = PageSegMode 7
psm_single_word  :: PageSegMode
psm_single_word  = PageSegMode 8
psm_circle_word  :: PageSegMode
psm_circle_word  = PageSegMode 9
psm_single_char  :: PageSegMode
psm_single_char  = PageSegMode 10
psm_sparse_text  :: PageSegMode
psm_sparse_text  = PageSegMode 11
psm_sparse_text_osd  :: PageSegMode
psm_sparse_text_osd  = PageSegMode 12
psm_raw_line  :: PageSegMode
psm_raw_line  = PageSegMode 13
psm_count  :: PageSegMode
psm_count  = PageSegMode 14

{-# LINE 63 "src/Tesseract/Bindings.hsc" #-}

newtype PageIteratorLevel = PageIteratorLevel { unPageIteratorLevel :: Int}
    deriving (Eq, Show)

ril_block  :: PageIteratorLevel
ril_block  = PageIteratorLevel 0
ril_para  :: PageIteratorLevel
ril_para  = PageIteratorLevel 1
ril_textline  :: PageIteratorLevel
ril_textline  = PageIteratorLevel 2
ril_word  :: PageIteratorLevel
ril_word  = PageIteratorLevel 3
ril_symbol  :: PageIteratorLevel
ril_symbol  = PageIteratorLevel 4

{-# LINE 74 "src/Tesseract/Bindings.hsc" #-}

newtype PolyBlockType = PolyBlockType { unPolyBlockType :: Int }
    deriving (Eq, Show)

pt_unknown  :: PolyBlockType
pt_unknown  = PolyBlockType 0
pt_flowing_text  :: PolyBlockType
pt_flowing_text  = PolyBlockType 1
pt_heading_text  :: PolyBlockType
pt_heading_text  = PolyBlockType 2
pt_pullout_text  :: PolyBlockType
pt_pullout_text  = PolyBlockType 3
pt_equation  :: PolyBlockType
pt_equation  = PolyBlockType 4
pt_inline_equation  :: PolyBlockType
pt_inline_equation  = PolyBlockType 5
pt_table  :: PolyBlockType
pt_table  = PolyBlockType 6
pt_vertical_text  :: PolyBlockType
pt_vertical_text  = PolyBlockType 7
pt_caption_text  :: PolyBlockType
pt_caption_text  = PolyBlockType 8
pt_flowing_image  :: PolyBlockType
pt_flowing_image  = PolyBlockType 9
pt_heading_image  :: PolyBlockType
pt_heading_image  = PolyBlockType 10
pt_pullout_image  :: PolyBlockType
pt_pullout_image  = PolyBlockType 11
pt_horz_line  :: PolyBlockType
pt_horz_line  = PolyBlockType 12
pt_vert_line  :: PolyBlockType
pt_vert_line  = PolyBlockType 13
pt_noise  :: PolyBlockType
pt_noise  = PolyBlockType 14
pt_count  :: PolyBlockType
pt_count  = PolyBlockType 15

{-# LINE 96 "src/Tesseract/Bindings.hsc" #-}

newtype Orientation = Orientation { unOrientation :: Int }
    deriving (Eq, Show)

orientation_page_up  :: Orientation
orientation_page_up  = Orientation 0
orientation_page_right  :: Orientation
orientation_page_right  = Orientation 1
orientation_page_down  :: Orientation
orientation_page_down  = Orientation 2
orientation_page_left  :: Orientation
orientation_page_left  = Orientation 3

{-# LINE 106 "src/Tesseract/Bindings.hsc" #-}

newtype ParagraphJustification = ParagraphJustification { unParagraphJust :: Int }
    deriving (Eq, Show)

justification_unknown  :: ParagraphJustification
justification_unknown  = ParagraphJustification 0
justification_left  :: ParagraphJustification
justification_left  = ParagraphJustification 1
justification_center  :: ParagraphJustification
justification_center  = ParagraphJustification 2
justification_right  :: ParagraphJustification
justification_right  = ParagraphJustification 3

{-# LINE 116 "src/Tesseract/Bindings.hsc" #-}

newtype WritingDirection = WritingDirection { unWritingDirection :: Int }
    deriving (Eq, Show)

writing_direction_left_to_right  :: WritingDirection
writing_direction_left_to_right  = WritingDirection 0
writing_direction_right_to_left  :: WritingDirection
writing_direction_right_to_left  = WritingDirection 1
writing_direction_top_to_bottom  :: WritingDirection
writing_direction_top_to_bottom  = WritingDirection 2

{-# LINE 125 "src/Tesseract/Bindings.hsc" #-}

newtype TextlineOrder = TextlineOrder { unTextlineOrder :: Int}
    deriving (Eq, Show)

textline_order_left_to_right  :: TextlineOrder
textline_order_left_to_right  = TextlineOrder 0
textline_order_right_to_left  :: TextlineOrder
textline_order_right_to_left  = TextlineOrder 1
textline_order_top_to_bottom  :: TextlineOrder
textline_order_top_to_bottom  = TextlineOrder 2

{-# LINE 134 "src/Tesseract/Bindings.hsc" #-}

-----------------------------
--
--          Types
--
-----------------------------

-----------------------------
--
--          Functions
--
-----------------------------
foreign import ccall "capi.h TessVersion"
    c_tesseract_version :: CString
