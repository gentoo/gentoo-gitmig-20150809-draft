# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eclectic/eclectic-0.9.1.ebuild,v 1.1 2005/05/08 01:56:53 ka0ttic Exp $

inherit bash-completion

DESCRIPTION="Modular -config replacement utility"
HOMEPAGE="http://developer.berlios.de/projects/eclectic/"
SRC_URI="http://download.berlios.de/eclectic/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

RDEPEND="app-shells/bash
	doc? ( dev-python/docutils )"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
	if use doc ; then
		cd doc ; make html || die "failed to build html"
	fi
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# removed until fixed/profiles.desc updated
	rm ${D}/usr/share/eclectic/modules/profile.eclectic
	rm ${D}/usr/share/man/man5/profile.eclectic.5

	dodoc README doc/*.txt
	use doc && dohtml doc/*.html
	dobashcompletion misc/eclectic.bashcomp
}
