themes=(
	casper
	lyra
)

for theme in "${themes[@]}"
do
	cp -Rf "node_modules/$theme" /app/themes/$theme
done