# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/vimspell/vimspell-1.70.ebuild,v 1.5 2004/04/07 22:50:00 lv Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: on-the-fly spell checking with aspell"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=465"
LICENSE="GPL-1 | GPL-2"
KEYWORDS="x86 sparc alpha ia64 ~ppc ~amd64"

# In theory, this plugin supports either aspell or ispell. However,
# virtual/spell has been removed by seemant in favour of just using
# app-text/aspell:
# 20:06 <@seemant> ciaranm: I think I might have removed it, come to
#   think of it, because I was on a kick to get everything converted
#   to aspell instead of ispell
# 20:06 <@seemant> for the simple reason that ispell blows dogs
# So we'll just force people to use aspell...
RDEPEND="$RDEPEND app-text/aspell"

function src_unpack() {
	unpack ${A}
	cd ${S}/plugin

	# This plugin needs to be told which spell program to use. The default
	# is hard-coded as 'ispell' in the plugin file. We can fix that with a
	# bit of sed magic. 
	OLD_DEFAULT='s:SpellGetOption("spell_executable","ispell")'
	NEW_DEFAULT='s:SpellGetOption("spell_executable","aspell")'
	sed -e "s/$OLD_DEFAULT/$NEW_DEFAULT/g" \
		-i vimspell.vim || die "default setting fix failed"

	# This plugin also tries to install its own documentation automatically
	# upon load. This breaks emerge unmerge, so we'll install the docs
	# manually.
	mkdir ${S}/doc || die
	cd ${S}/doc
	cp ${S}/plugin/vimspell.vim vimspell.txt

	sed -e "1,/^=== \+START_DOC/d" \
		-e "/^=== \+END_DOC/,\$d"  \
		-e "s/{{{[1-9]/    /g"     \
		-e "s/#version#/v${PV}/g"  \
		-i vimspell.txt || die "docs failed"
	echo -ne "\n vim:tw=78:ts=8:ft=help:norl:\n" >> vimspell.txt

	# Unfortunately, there's a rather large logic error in the documentation
	# installation code. If vim can't write to /usr/share/vim/vimfiles/doc/
	# then the plugin will try to install a copy of the docs locally, even if
	# the global directory has an up-to-date copy. To get around this we'll
	# make the SpellInstallDocumentation function do nothing.
	cd ${S}/plugin
	sed -e "/^function! s:SpellInstallDocumentation/a\    return 0" \
		-i vimspell.vim || die "install fix failed"
}

