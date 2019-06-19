# Pixeldisplay

## Om skærmen
Pixeldisplayet er en lavopløsningsskærm designet og bygget af DD Lab. Skærmen er tænkt som en resource til studerende på Digital Design og Informationsvidensskab og kan anvendes til projekter på forespørsel.

Displayet har en opløsning på 12x16 og måler 68x100,5 cm hvor selve skærmområdet måler 68x81 cm.

## Inden du går i gang
Skærmens pixels udgøres af rækker af LED-strips der styres gennem et [FadeCandy Controller Board](https://www.adafruit.com/product/1689). For at kunne bruge skærmen skal man altså anvende et bibliotek ved navn Open Pixel Control (OPC).
Der findes versioner af OPC til både processing og p5.js. I p5.js inkluderes biblioteket på samme måde som normalt, mens processing-versionen af OPC skal indsættes i en fane i din processingkode og ikke installeres som du normalt ville installere et bibliotek i processing. Se vores skeletkode og eksemplerkoder for eksempler på hvordan det ser ud i praksis.

Udover OPC biblioteket er det også nødvendigt at hente og køre en FadeCandy Server, der afvikler kommunikationen mellem din computer og fadecandy-boardet.

Følg [denne vejledning fra Adafruit](https://learn.adafruit.com/led-art-with-fadecandy/installing-software), der guider dig igennem installationen af de nødvendige programmer. Hvis du vil bruge javascript kan du ignorere installationen af processing.

## Brug skærmen
Når du har installeret alle programmerne fra ovenstående afsnit, er du klar til at bruge displayet. Da displayet har nogle ualmindelige dimensioner, vil du få problemer med at afvikle de eksempler der følger med biblioteket, uden først at ændre i koden.

Derfor har vi selv lavet eksempelkode, som du kan finde i mappen `Eksempler`. Eksemplerne kan bruges som de er, men du er selvfølgelig velkommen til at modificere dem og bruge dem som byggesten til dine egne projekter.

Hvis du gerne vil starte med et rent kanvas, har vi skrevet et stykke skeletkode, som du kan finde i mappen `Skeletkode`. Koden indeholder de funktioner og biblioteker, der er nødvendige for at bruge displayet, så du skal bare bekymre dig om at tegne din grafik.

## Læs mere
Du kan læse mere om fadecandy boardet på deres [github repository](https://github.com/scanlime/fadecandy) og på [adafruits produktside](https://www.adafruit.com/product/1689).

Adafruit har også skrevet en [fin guide](https://learn.adafruit.com/led-art-with-fadecandy/intro) om at lave LED kunst med fadecandy, der både indeholder kodeeksempler og overvejelser om det kreative udtryk og resultat.
