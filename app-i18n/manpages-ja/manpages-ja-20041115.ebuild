# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/manpages-ja/manpages-ja-20041115.ebuild,v 1.1 2004/11/23 13:07:17 hattya Exp $

IUSE=""

MY_P="man-pages-ja-${PV}"
GENTOO_MAN_P="portage-${P}"

DESCRIPTION="A collection of manual pages translated into Japanese"
HOMEPAGE="http://www.linux.or.jp/JM/ http://www.gentoo.gr.jp/jpmain/translation.xml"
SRC_URI="http://www.linux.or.jp/JM/${MY_P}.tar.gz
	http://dev.gentoo.org/~hattya/distfiles/${GENTOO_MAN_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
SLOT="0"
S="${WORKDIR}/${MY_P}"

DEPEND="!>=sys-apps/groff-1.19
	=sys-apps/groff-1.18*
	sys-apps/man"

pkg_setup() {

	if ! groff -v -Tnippon >/dev/null 2>&1 ; then
		ewarn
		ewarn "You need to compile groff with multilingual support."
		ewarn "Please recompile sys-apps/groff with USE=\"cjk\"."
		ewarn
		die "groff m17n support disabled."
	fi

}

src_compile() {

	return

}

src_install() {

	local x y z

	for x in $(grep '^[^#].*' script/pkgs.list | cut -f1 | sort); do
		for y in $(ls -d manual/$x/man* 2>/dev/null); do
			jmandir=$(echo $y | cut -d/ -f3)

			einfo "$(printf "install %-20s  /usr/share/man/ja/$jmandir" $x:)"

			insinto /usr/share/man/ja/$jmandir
			doins $y/*
		done
	done

	cd ${WORKDIR}/${GENTOO_MAN_P}

	for x in *; do
		if [ -d "$x" ]; then
			for z in $(for y in $x/*.[1-9]; do echo ${y##*.}; done | sort | uniq); do
				einfo "$(printf "install %-20s  /usr/share/man/ja/man$z" $x:)"

				insinto /usr/share/man/ja/man$z
				doins $x/*.$z
			done
		fi
	done

	newdoc ChangeLog ChangeLog.GentooJP
	cd -

	dodoc ChangeLog INSTALL README

}

pkg_postinst() {

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
