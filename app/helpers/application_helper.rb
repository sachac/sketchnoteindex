module ApplicationHelper
  def action_list(o)
    list = Array.new
    if o.instance_of? Sketch
      list << link_to(t('action.view_sketch'), o.url, :class => 'icon-eye-open icon')
    else
      list << link_to(t('action.view'), o, :class => 'icon-folder-open icon')
    end
    if can? :manage, o
      list << link_to(t('action.edit'), [:edit, o], :class => 'icon-pencil icon')
      list << link_to(t('action.destroy'), o, method: :delete, data: { confirm: 'Are you sure?' }, :class => 'icon-trash icon')
    end
    list.join(' ').html_safe
  end

  def collection_name(collection)
    collection.name || I18n.t('untitled_collection')
  end

  def nav_link(*args, &block)
    if block_given?
      options      = args.first || {}
      html_options = args.second
      nav_link(capture(&block), options, html_options)
    else
      name         = args[0]
      options      = args[1] || {}
      html_options = args[2]

      html_options = convert_options_to_data_attributes(options, html_options)
      url = url_for(options)

      class_name = current_page?(url) ? 'active' : nil

      href = html_options['href']
      tag_options = tag_options(html_options)

      href_attr = "href=\"#{ERB::Util.html_escape(url)}\"" unless href
      "<li class=\"#{class_name}\"><a #{href_attr}#{tag_options}>#{ERB::Util.html_escape(name || url)}</a></li>".html_safe
    end
  end
end
