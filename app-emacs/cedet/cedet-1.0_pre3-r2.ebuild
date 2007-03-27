# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/cedet/cedet-1.0_pre3-r2.ebuild,v 1.6 2007/03/27 18:49:09 welp Exp $

inherit elisp eutils

MY_PV=${PV:0:3}${PV:4:5}

IUSE=""
DESCRIPTION="CEDET: Collection of Emacs Development Tools"
HOMEPAGE="http://cedet.sourceforge.net/"
SRC_URI="mirror://sourceforge/cedet/${PN}-${MY_PV}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~ppc-macos x86"
DEPEND="virtual/emacs
	!app-emacs/semantic
	!app-emacs/eieio
	!app-emacs/speedbar"

S="${WORKDIR}/${PN}-${MY_PV}"

SITEFILE="60cedet-gentoo.el"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/1.0_pre3-eieio-tests-gentoo.patch" # Bug #124598
	epatch "${FILESDIR}/1.0_pre3-sb-info-circular-dep-gentoo.patch" # Bug #138190
	epatch "${FILESDIR}/1.0_pre3-idle-gentoo.patch" # Bug #149842
}

src_compile() {
	make EMACS=/usr/bin/emacs || die
}

src_install() {
	find "${S}" -type f -print \
		| while read target; do
			local directory=`dirname $target` file=`basename $target`
			local sub_directory=`echo $directory | sed "s%^${S}/*%%;s/^$/./"`
			case $file in
				*~ | Makefile | *.texi | *-script | PRERELEASE_CHECKLIST | Project.ede)
					rm -f ${file}
					;;
				ChangeLog | README | AUTHORS | *NEWS | INSTALL)
					docinto ${sub_directory}
					dodoc ${target}
					;;
				*.png)
					insinto /usr/share/doc/${PF}/${sub_directory}
					doins ${target}
					;;
				IMPLICIT_TARGETS)
					;;
				*.el | *.elc)
					insinto /usr/share/emacs/site-lisp/cedet/${sub_directory}
					doins ${target}
					;;
				*.info*)
					doinfo ${target}
					;;
				*)
					insinto /usr/share/emacs/site-lisp/cedet/${sub_directory}
					doins ${target}
					echo ${target} >>"${S}/IMPLICIT_TARGETS"
					;;
			esac
		done
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
}
