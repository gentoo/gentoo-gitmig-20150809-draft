# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/manpages-ja/manpages-ja-20030815.ebuild,v 1.1 2003/08/21 11:28:25 usata Exp $

IUSE=""
HOMEPAGE="http://www.linux.or.jp/JM/"
DESCRIPTION="A collection of manual pages translated into Japanese"

SRC_URI="http://www.linux.or.jp/JM/man-pages-ja-${PV}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
S="${WORKDIR}/man-pages-ja-${PV}"

DEPEND=""
RDEPEND=">=sys-apps/groff-1.18.1-r2
	sys-apps/man"

src_install () {

	for x in $(grep '^[^#].*' script/pkgs.list | cut -f1 | sort)
	do
		for a in $(ls -d manual/$x/man* 2>/dev/null)
		do
			jmandir=$(echo $a | cut -d/ -f3)

			echo install $x:  /usr/share/man/ja/$jmandir/

			insinto /usr/share/man/ja/$jmandir
			doins $a/*
		done
	done

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
