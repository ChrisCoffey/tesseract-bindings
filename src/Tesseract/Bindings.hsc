{-# LANGUAGE CPP, ForeignFunctionInterface #-}
module Tesseract.Bindings (
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
    ,tesseract_version
) where

import Protolude

import Foreign
import Foreign.C.String
import Foreign.C.Types

#include <tesseract/capi.h>

-----------------------------
--
--      Enumerations
--
-----------------------------

newtype OcrEngineMode = OcrEngineMode { unEngineMode :: Int }
    deriving (Eq, Show)

#{enum OcrEngineMode, OcrEngineMode
    , tesseract_only = OEM_TESSERACT_ONLY
    , lstm_only = OEM_LSTM_ONLY
    , tesseract_lstm_combined = OEM_TESSERACT_LSTM_COMBINED
    , oem_default = OEM_DEFAULT
 }

newtype PageSegMode = PageSegMode { unPageSegMode :: Int }
    deriving (Eq, Show)

#{enum PageSegMode, PageSegMode
    ,psm_osd_only = PSM_OSD_ONLY
    ,psm_auto_osd = PSM_AUTO_OSD
    ,psm_auto_only = PSM_AUTO_ONLY
    ,psm_auto = PSM_AUTO
    ,psm_single_column = PSM_SINGLE_COLUMN
    ,psm_single_block_vert_text = PSM_SINGLE_BLOCK_VERT_TEXT
    ,psm_single_block = PSM_SINGLE_BLOCK
    ,psm_single_line = PSM_SINGLE_LINE
    ,psm_single_word = PSM_SINGLE_WORD
    ,psm_circle_word = PSM_CIRCLE_WORD
    ,psm_single_char = PSM_SINGLE_CHAR
    ,psm_sparse_text = PSM_SPARSE_TEXT
    ,psm_sparse_text_osd = PSM_SPARSE_TEXT_OSD
    ,psm_raw_line = PSM_RAW_LINE
    ,psm_count = PSM_COUNT
 }

newtype PageIteratorLevel = PageIteratorLevel { unPageIteratorLevel :: Int}
    deriving (Eq, Show)

#{enum PageIteratorLevel, PageIteratorLevel
    ,ril_block = RIL_BLOCK
    ,ril_para = RIL_PARA
    ,ril_textline = RIL_TEXTLINE
    ,ril_word = RIL_WORD
    ,ril_symbol = RIL_SYMBOL
}

newtype PolyBlockType = PolyBlockType { unPolyBlockType :: Int }
    deriving (Eq, Show)

#{enum PolyBlockType, PolyBlockType
    ,pt_unknown = PT_UNKNOWN
    ,pt_flowing_text = PT_FLOWING_TEXT
    ,pt_heading_text = PT_HEADING_TEXT
    ,pt_pullout_text = PT_PULLOUT_TEXT
    ,pt_equation = PT_EQUATION
    ,pt_inline_equation = PT_INLINE_EQUATION
    ,pt_table = PT_TABLE
    ,pt_vertical_text = PT_VERTICAL_TEXT
    ,pt_caption_text = PT_CAPTION_TEXT
    ,pt_flowing_image = PT_FLOWING_IMAGE
    ,pt_heading_image = PT_HEADING_IMAGE
    ,pt_pullout_image = PT_PULLOUT_IMAGE
    ,pt_horz_line = PT_HORZ_LINE
    ,pt_vert_line = PT_VERT_LINE
    ,pt_noise = PT_NOISE
    ,pt_count = PT_COUNT
}

newtype Orientation = Orientation { unOrientation :: Int }
    deriving (Eq, Show)

#{enum Orientation, Orientation
    ,orientation_page_up = ORIENTATION_PAGE_UP
    ,orientation_page_right = ORIENTATION_PAGE_RIGHT
    ,orientation_page_down = ORIENTATION_PAGE_DOWN
    ,orientation_page_left = ORIENTATION_PAGE_LEFT
}

newtype ParagraphJustification = ParagraphJustification { unParagraphJust :: Int }
    deriving (Eq, Show)

#{enum ParagraphJustification, ParagraphJustification
  ,justification_unknown = JUSTIFICATION_UNKNOWN
  ,justification_left = JUSTIFICATION_LEFT
  ,justification_center = JUSTIFICATION_CENTER
  ,justification_right = JUSTIFICATION_RIGHT
}

newtype WritingDirection = WritingDirection { unWritingDirection :: Int }
    deriving (Eq, Show)

#{enum WritingDirection, WritingDirection
    ,writing_direction_left_to_right = WRITING_DIRECTION_LEFT_TO_RIGHT
    ,writing_direction_right_to_left = WRITING_DIRECTION_RIGHT_TO_LEFT
    ,writing_direction_top_to_bottom = WRITING_DIRECTION_TOP_TO_BOTTOM
}

newtype TextlineOrder = TextlineOrder { unTextlineOrder :: Int}
    deriving (Eq, Show)

#{enum TextlineOrder, TextlineOrder
    ,textline_order_left_to_right = TEXTLINE_ORDER_LEFT_TO_RIGHT
    ,textline_order_right_to_left = TEXTLINE_ORDER_RIGHT_TO_LEFT
    ,textline_order_top_to_bottom = TEXTLINE_ORDER_TOP_TO_BOTTOM
}


-- | ETEXT_DESC
-- | Description of the output of the OCR engine.
-- | This structure is used as both a progress monitor and the final
-- | output header, since it needs to be a valid progress monitor while
-- | the OCR engine is storing its output to shared memory.
-- | During progress, all the buffer info is -1.
-- | Progress starts at 0 and increases to 100 during OCR. No other constraint.
-- | Additionally the progress callback contains the bounding box of the word that
-- | is currently being processed.
-- | Every progress callback, the OCR engine must set ocr_alive to 1.
-- | The HP side will set ocr_alive to 0. Repeated failure to reset
-- | to 1 indicates that the OCR engine is dead.
-- | If the cancel function is not null then it is called with the number of
-- | user words found. If it returns true then operation is cancelled.

-----------------------------
--
--          Types
--
-----------------------------
data ETextDesc = ETextDesc
    { count :: CInt
    , progress :: CInt
    , moreToCome :: CInt
    , ocrAlive :: CInt
    , errCode :: CInt
    , endTime :: CInt
    } deriving (Eq, Show)

data Pix
data Boxa
data Pixa

data ResultRenderer
-----------------------------
--
--          Functions
--
-----------------------------

-- Free functions, meaning not associated with a specific tesseract class

-- Returns the loaded tesseract version
foreign import ccall "capi.h TessVersion"
    c_tesseract_version :: CString

foreign import ccall "capi.h TessDeleteText"
    c_delete_text :: CString -> IO ()

foreign import ccall "capi.h TessDeleteTextArray"
    c_delete_text_array :: Ptr CString -> IO ()

foreign import ccall "capi.h TessDeleteIntArray"
    c_delete_int_array :: Ptr CInt -> IO ()


-- Renderer API
-- The `ResultRenderer` itself is uninhabited, entirely managed by C

foreign import ccall "capi.h TessTextRendererCreate"
    c_create_text_renderer :: CString -> IO ResultRenderer

foreign import ccall "capi.h TessHOcrRendererCreate"
    c_create_hocr_renderer :: CString -> IO ResultRenderer

-- This includes an additional flag for font info
foreign import ccall "capi.h TessHOcrRendererCreate2"
    c_create_hocr_renderer_font :: CString -> CBool -> IO ResultRenderer

foreign import ccall "capi.h TessAltRendererCreate"
    c_create_alto_renderer :: CString -> IO ResultRenderer

foreign import ccall "capi.h TessTsvRendererCreate"
    c_create_tsv_renderer :: CString -> IO ResultRenderer

foreign import ccall "capi.h TessPDFRendererCreate"
    c_create_pdf_renderer ::
           CString
        -> CString
        -> CBool
        -> IO ResultRenderer

foreign import ccall "capi.h TessUnlvRendererCreate"
    c_create_unlv_renderer :: CString -> IO ResultRenderer

foreign import ccall "capi.h TessBoxTextRendererCreate"
    c_create_box_text_renderer :: CString -> IO ResultRenderer

foreign import ccall "capi.h TessLSTMBoxRendererCreate"
    c_create_lstmbox_text_renderer :: CString -> IO ResultRenderer

foreign import ccall "capi.h TessWordStrBoxRendererCreate"
    c_create_wordstrbox_text_renderer :: CString -> IO ResultRenderer

foreign import ccall "capi.h TessDeleteResultRenderer"
    c_delete_result_renderer :: ResultRenderer -> IO ()

foreign import ccall "capi.h TessResultRendererInsert"
    c_insert_result_renderer :: ResultRenderer -> ResultRenderer -> IO ()

TessResultRenderer* TESS_CALL TessResultRendererNext(TessResultRenderer* renderer);
BOOL TESS_CALL TessResultRendererBeginDocument(TessResultRenderer* renderer, const char* title);
BOOL TESS_CALL TessResultRendererAddImage(TessResultRenderer* renderer, TessBaseAPI* api);
BOOL TESS_CALL TessResultRendererEndDocument(TessResultRenderer* renderer);

const char* TESS_CALL TessResultRendererExtention(TessResultRenderer* renderer);
const char* TESS_CALL TessResultRendererTitle(TessResultRenderer* renderer);
int TESS_CALL TessResultRendererImageNum(TessResultRenderer* renderer);
