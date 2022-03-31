themes=(
	casper
	lyra
	ruby
)

for theme in "${themes[@]}"
do
	cp -Rf "node_modules/$theme" /app/themes/$theme
done