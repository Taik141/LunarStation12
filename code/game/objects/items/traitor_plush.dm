/obj/item/reagent_containers/food/snacks/dehydrated_carp
	name = "pelucia de capa"
	desc = "Uma peluche de uma carpa exultante! Diretamente dos confins da fronteira de Nyx, agora mesmo aqui nas suas maos."
	atom_flags = ATOM_FLAG_NO_TEMP_CHANGE | ATOM_FLAG_OPEN_CONTAINER
	icon = 'icons/obj/toy.dmi'
	icon_state = "carpplushie"
	filling_color = "#522666"

	var/spawned_mob = /mob/living/simple_animal/hostile/carp

/obj/item/reagent_containers/food/snacks/dehydrated_carp/Initialize()
	. = ..()
	reagents.add_reagent(/datum/reagent/nutriment/protein, 10)

/obj/item/reagent_containers/food/snacks/dehydrated_carp/attack_self(mob/user)
	if (user.a_intent == I_HELP)
		user.visible_message(SPAN_NOTICE("\The [user] Abraça [src]!"), SPAN_NOTICE("Voce abraça [src]!"))
	else if (user.a_intent == I_HURT)
		user.visible_message(SPAN_WARNING("\The [user] bate [src]!"), SPAN_WARNING("Voce bateu [src]!"))
	else if (user.a_intent == I_GRAB)
		user.visible_message(SPAN_WARNING("\The [user] attempts to strangle [src]!"), SPAN_WARNING("You attempt to strangle [src]!"))
	else
		user.visible_message(SPAN_NOTICE("\The [user] pokes [src]."), SPAN_NOTICE("You poke [src]."))

/obj/item/reagent_containers/food/snacks/dehydrated_carp/on_reagent_change()
	if (reagents.has_reagent(/datum/reagent/water))
		visible_message(SPAN_WARNING("\The [src] Começa a chaqualha o liquido."))
		addtimer(new Callback(src, .proc/expand), 5 SECONDS)

/obj/item/reagent_containers/food/snacks/dehydrated_carp/proc/expand()
	visible_message(SPAN_WARNING("\The [src] rapidly expands into a living space carp!"))
	new spawned_mob(get_turf(src))
	qdel(src)

/obj/item/reagent_containers/food/snacks/dehydrated_carp/get_antag_interactions_info()
	. = ..()
	.["Water"] += "<p>Hidrata a peluche, transformando-a numa carpa espacial viva apas um curto periodo de tempo. Tem cuidado, pois a carpa também será hostil para ti!</p>"

/obj/item/plushbomb
	name = "peluche de gatinho"
	desc = "Uma peluche de um gatinho muito giro! Veja como ele ronrona ate ao seu coraçao."
	icon = 'icons/obj/toy.dmi'
	icon_state = "kittenplushie"
	var/phrase
	var/last_words = "Meow"

/obj/item/plushbomb/Initialize()
	. = ..()
	GLOB.listening_objects += src

/obj/item/plushbomb/Destroy()
	GLOB.listening_objects -= src
	return ..()

/obj/item/plushbomb/attack_self(mob/user)
	if (user.a_intent == I_HELP)
		user.visible_message(SPAN_NOTICE("\The [user] hugs [src]!"), SPAN_NOTICE("You hug [src]!"))
	else if (user.a_intent == I_GRAB)
		if (!phrase)
			phrase = sanitize_phrase(input("Choose activation phrase:") as text)
			to_chat(user, SPAN_NOTICE("You set the activation phrase to be '[phrase]'."))
		else
			user.visible_message(SPAN_WARNING("\The [user] tentativas de estrangulamento [src]!"), SPAN_WARNING("Tentas estrangular [src]!"))
	else if (user.a_intent == I_HURT)
		user.visible_message(SPAN_WARNING("\The [user] Bateu [src]!"), SPAN_WARNING("Voce bateu [src]!"))
	else
		user.visible_message(SPAN_NOTICE("\The [user] pokes [src]."), SPAN_NOTICE("You poke [src]."))

/obj/item/plushbomb/hear_talk(mob/M, msg)
	if (!phrase)
		return
	if (findtext(sanitize_phrase(msg), phrase))
		addtimer(new Callback(src, .proc/activate), 5 SECONDS)
		audible_message(SPAN_DANGER("\The [src] begins to beep ominously, letting out a loud '[last_words]'!"))
		playsound(loc, 'sound/weapons/armbomb.ogg', 75, 1, -3)

/obj/item/plushbomb/proc/sanitize_phrase(phrase)
	var/list/replacechars = list("'" = "","\"" = "",">" = "","<" = "","(" = "",")" = "")
	return replace_characters(phrase, replacechars)

/obj/item/plushbomb/proc/activate()
	explosion(src.loc, 3, EX_ACT_HEAVY)
	qdel(src)

/obj/item/plushbomb/get_antag_info()
	. = ..()
	. += "Set an activation phrase by using the plush on grab intent. Upon hearing the trigger phrase, the plush will explode after a 5 second countdown."

/obj/item/plushbomb/nymph
	name = "peluche ninfa diona"
	desc = "Uma peluche de uma adoravel ninfa diona! Embora o seu nivel de auto-consciencia ainda esteja a ser debatido, o seu nível de fofura nao esta."
	icon_state = "nymphplushie"
	last_words = "Chirp"

/obj/item/plushbomb/spider
	name = "Peluch de aranha"
	desc = "Uma peluche de uma aranha felpuda! Tem oito patas, para te abraçar melhor."
	icon_state = "spiderplushie"
	last_words = "Chitter"

/obj/item/plushbomb/carp
	name = "carpa de pelucia"
	desc = "Uma carpa espacial roxa de peluche. Menos ameaçadora do que a verdadeira."
	icon_state = "carp-purple"
	last_words = "Gnash"

/obj/item/plushbomb/carp/gold
	desc = "Uma carpa espacial dourada de peluche. Menos ameaçadora do que a verdadeira."
	icon_state = "carp-gold"

/obj/item/plushbomb/carp/pink
	desc = "Uma carpa espacial cor-de-rosa de peluche. Menos ameaçadora do que a verdadeira."
	icon_state = "carp-pink"

/obj/item/plushbomb/corgi
	name = "pelucia de corgi"
	desc = "Um corgi de peluche. O facto de ser pequeno torna-o mais giro."
	icon_state = "corgi"
	last_words = "Bark"

/obj/item/plushbomb/corgi/bow
	desc = "Um corgi de peluche com um pequeno laço na cabeça. O facto de ser pequeno torna-o mais giro."
	icon_state = "corgi-bow"

/obj/item/plushbomb/deer
	name = "pelucia de veado"
	desc = "Um veado de peluche. De alguma forma ainda majestoso."
	icon_state = "deer"
	last_words = "Bleat"

/obj/item/plushbomb/squid
	name = "Pelucia de lula"
	desc = "Uma pelucia azul. Tentacular."
	icon_state = "squid-blue"
	last_words = "Squish"

/obj/item/plushbomb/squid/orange
	name = "Pelucia de lula"
	desc = "Uma pelucia laranja. Tentacular."
	icon_state = "squid-orange"

/obj/item/plushbomb/thoom
	name = "pelucia th'oom"
	desc = "Um Th'oom de peluche com grandes olhos de botao. Cheira a cogumelos."
	icon_state = "thoomplushie"
	last_words = "Q'moo"
