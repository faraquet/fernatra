# frozen_string_literal: true

class PdfController < ApplicationController
  def create
    browser = Ferrum::Browser.new(timeout: 300, browser_options: { 'no-sandbox': nil })
    filename = "temp-#{DateTime.now.strftime('%Q')}"
    File.write("tmp/#{filename}.html", params[:content])

    browser.go_to("file:///#{Rails.root.join("tmp/#{filename}.html")}")
    pdf_options = { path: "tmp/#{filename}.pdf" }

    if params[:landscape].present?
      pdf_options[:landscape] =
        ActiveRecord::Type::Boolean.new.deserialize(params[:landscape])
    end

    pdf_options[:scale] = ActiveRecord::Type::Float.new.deserialize(params[:scale]) if params[:scale].present?
    browser.pdf(**pdf_options)

    send_file "tmp/#{filename}.pdf", type: 'pdf'
  end
end
