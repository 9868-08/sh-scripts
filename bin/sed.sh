find -type f -name \*.py -exec sed -i -r 's/text_1/text_2/g' {} \;
#Remove blank lines with grep
# grep -v -e '^$' foo.txtx
