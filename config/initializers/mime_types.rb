# Be sure to restart your server when you modify this file.

# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
# Mime::Type.register "application/vnd.ms-office", :xls, [], %w(xls)
# Mime::Type.unregister(:docx)

Mime::Type.register "application/vnd.openxmlformats-officedocument.wordprocessingml.document", :docx, [], %w(docx)

#Mime::Type.register "application/msword", :doc, [], %w(doc dot)
Mime::Type.unregister(:pdf)
Mime::Type.register "application/force-download", :pdf, [], %w(pdf)