# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/xrn/xrn-9.02.ebuild,v 1.1 2004/07/23 22:51:21 swegener Exp $

DESCRIPTION="A small and fast news reader for X."
HOMEPAGE="http://www.mit.edu/people/jik/software/xrn.html"
SRC_URI="ftp://sipb.mit.edu/pub/${PN}/${P}.tgz"
LICENSE="BSD"
SLOT="0"

KEYWORDS="~x86"
IUSE=""

RDEPEND="virtual/x11"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

src_compile() {
	# English is the default language, but french and german are also
	# supported, however only one language may be supported at a time:
	for lingua in ${LINGUAS} en ; do
		case "$lingua" in
			en*)
				MY_LANG="english"
				break # Breaks the for loop.
				;;
			fr*)
				MY_LANG="french"
				break # Breaks the for loop.
				;;
			de*)
				MY_LANG="german"
				break # Breaks the for loop.
				;;
		esac
	done

	# Bugs to Gentoo bugzilla:
	sed -i \
		-e "s,bug-xrn@kamens.brookline.ma.us,http://bugs.gentoo.org/," \
		-e "s,\(#ifndef CONFIG_H_IS_OK\),#define CONFIG_H_IS_OK\n\1," \
		config.h

	# Generate Makefile:
	xmkmf || die "xmkmf failed"

	# Use our own CFLAGS and our desired language:
	emake CDEBUGFLAGS="${CFLAGS}" LANGUAGE="${MY_LANG}" || die "emake failed"
}

src_install() {
	dobin xrn || die "dobin failed"
	dodoc README README.Linux TODO CREDITS COMMON-PROBLMS || die "dodoc failed"

	# Default settings:
	insinto /etc/X11/app-defaults
	newins XRn.ad XRn

	newman xrn.man xrn.1
}
