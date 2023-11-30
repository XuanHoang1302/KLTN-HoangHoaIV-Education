# frozen_string_literal: true

class ExcelImport < ViewComponent::Base
  def initialize(
    sheet_id,
    prepare_import_path,
    import_path,
    labels = {
      import_button_text: nil,
      import_dialog_title: nil,
      import_dialog_text: nil,
      import_download_template_title: nil,
      import_download_template_desc: nil,
      import_upload_excel_title: nil,
      import_upload_excel_desc: nil,
      download_template_button: nil,
      upload_excel_button: nil
    },
    user_id = nil
  )
    @sheet_id = sheet_id
    @import_path = import_path
    @prepare_import_path = prepare_import_path
    @import_button_text = labels[:import_button_text]
    @import_dialog_title = labels[:import_dialog_title]
    @import_dialog_text = labels[:import_dialog_text]
    @import_download_template_title = labels[:import_download_template_title]
    @import_download_template_desc = labels[:import_download_template_desc]
    @import_upload_excel_title = labels[:import_upload_excel_title]
    @import_upload_excel_desc = labels[:import_upload_excel_desc]
    @download_template_button = labels[:download_template_button]
    @upload_excel_button = labels[:upload_excel_button]
    @user_id = user_id.nil? ? Current.user.id : user_id
  end
end
