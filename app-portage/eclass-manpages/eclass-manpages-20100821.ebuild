# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/eclass-manpages/eclass-manpages-20100821.ebuild,v 1.1 2010/08/21 19:31:12 vapier Exp $

DESCRIPTION="collection of Gentoo eclass manpages"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~x86-solaris"
IUSE=""

DEPEND=""
RDEPEND="!app-portage/portage-manpages"

S=${WORKDIR}

src_compile() {
	local e
	for e in "${ECLASSDIR}"/*.eclass ; do
		gawk -f "${FILESDIR}"/eclass-to-manpage.awk ${e} > ${e##*/}.5 || rm -f ${e##*/}.5
	done
}

src_install() {
	doman *.5 || die
}
