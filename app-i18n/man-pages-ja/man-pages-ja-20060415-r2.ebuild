# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-ja/man-pages-ja-20060415-r2.ebuild,v 1.13 2006/12/30 13:49:34 usata Exp $

IUSE=""

GENTOO_MAN_P=portage-${P}

DESCRIPTION="A collection of manual pages translated into Japanese"
HOMEPAGE="http://www.linux.or.jp/JM/ http://www.gentoo.gr.jp/jpmain/translation.xml"
SRC_URI="http://www.linux.or.jp/JM/${P}.tar.gz
	http://dev.gentoo.org/~hattya/distfiles/${GENTOO_MAN_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
SLOT="0"

DEPEND="sys-apps/groff
	virtual/man"

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

	sed -i \
		-e "/^man/s:Y:N:" \
		-e "/^shadow/s:Y:N:" \
		script/pkgs.list

}

src_install() {

	local x y z pkg

	for x in $(tac script/pkgs.list | grep -v '^[#].*'); do
		if [[ -z "$pkg" ]]; then
			pkg=$x
			continue
		fi

		if [[ "$x" == "N" ]]; then
			pkg=
			continue
		fi

		einfo "install $pkg"

		for y in $(ls -d manual/$pkg/man* 2>/dev/null); do
			insinto /usr/share/man/ja/$(echo $y | cut -d/ -f3)
			doins $y/*
		done

		pkg=
	done

	# remove man pages that are provided by other packages.
	# - sys-apps/shadow +nls
	rm -f "${D}"/usr/share/man/ja/man1/{chfn,chsh,newgrp,su,passwd,groups}.1
	rm -f "${D}"/usr/share/man/ja/man8/{vigr,vipw}.8

	dodoc ChangeLog README


	cd "${WORKDIR}"/${GENTOO_MAN_P}

	for x in *; do
		if [ -d "$x" ]; then
			einfo "install $x"

			for z in $(for y in $x/*.[1-9]; do echo ${y##*.}; done | sort | uniq); do
				insinto /usr/share/man/ja/man$z
				doins $x/*.$z
			done
		fi
	done

	newdoc ChangeLog ChangeLog.GentooJP

}

pkg_postinst() {

	echo
	elog "You need to set appropriate LANG and PAGER variables to use"
	elog "Japanese manpages."
	elog "e.g."
	elog "\tLANG=\"ja_JP.eucJP\""
	elog "\tPAGER=\"jless\""
	elog "\tJLESSCHARSET=\"ja\""
	elog "\texport LANG PAGER JLESSCHARSET"
	elog "or"
	elog "\tLANG=\"ja_JP.eucJP\""
	elog "\tPAGER=\"lv -c\""
	elog "\texport LANG PAGER"
	echo

}
