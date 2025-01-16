sed \
  -e 's/<span class="calibre1"><span class="bold">\([^<]*\)<\/span><\/span>/# \1/' \
  -e 's/<span class="calibre3">\([^<]*\)<\/span>/## \1/' \
  $1
