# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/manpages-ja/manpages-ja-20031215.ebuild,v 1.3 2004/01/18 17:16:06 gustavoz Exp $

IUSE=""

MY_P="man-pages-ja-${PV}"

HOMEPAGE="http://www.linux.or.jp/JM/
	http://www.gentoo.gr.jp/jpmain/translation.xml"
DESCRIPTION="A collection of manual pages translated into Japanese"
SRC_URI="http://www.linux.or.jp/JM/${MY_P}.tar.gz
	http://dev.gentoo.org/~usata/distfiles/portage-${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~ppc sparc alpha ~mips hppa ~arm ~amd64"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND=""
RDEPEND=">=sys-apps/groff-1.18.1-r2
	sys-apps/man"

src_install () {

	for x in $(grep '^[^#].*' script/pkgs.list | cut -f1 | sort)
	do
		for a in $(ls -d manual/$x/man* 2>/dev/null)
		do
			jmandir=$(echo $a | cut -d/ -f3)

			einfo install $x:  /usr/share/man/ja/$jmandir/

			insinto /usr/share/man/ja/$jmandir
			doins $a/*
		done
	done

	cd ${WORKDIR}/portage/man/ja
	for y in *; do
		einfo install ${y%.*}:  /usr/share/man/ja/man${y##*.}/
		insinto /usr/share/man/ja/man${y##*.}
		doins $y
	done
	cd -

	dodoc ChangeLog INSTALL README
}

pkg_postinst () {

	einfo
	einfo "You need to set appropriate LANG and PAGER variables to use"
	einfo "Japanese manpages."
	einfo "e.g."
	einfo "\tLANG=\"ja_JP.eucJP\""
	einfo "\tPAGER=\"jless\""
	einfo "\tJLESSCHARSET=\"ja\""
	einfo "\texport LANG PAGER JLESSCHARSET"
	einfo "or"
	einfo "\tLANG=\"ja_JP.eucJP\""
	einfo "\tPAGER=\"lv -c\""
	einfo "\texport LANG PAGER"
	einfo
}
