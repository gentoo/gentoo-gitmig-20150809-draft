# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/pilot-mailsync/pilot-mailsync-0.8.3.ebuild,v 1.3 2007/01/29 01:57:12 mr_bones_ Exp $

inherit flag-o-matic

DESCRIPTION="An application to transfer outgoing mail from and deliver incoming mail to a Palm OS device."
HOMEPAGE="http://wissrech.iam.uni-bonn.de/people/garcke/pms/"
SRC_URI="http://wissrech.iam.uni-bonn.de/people/garcke/pms/${P}.tar.gz"

LICENSE="MPL-1.0"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="ssl gnome"

DEPEND="ssl? ( dev-libs/openssl )
	gnome? ( >=app-pda/gnome-pilot-2 )
	>=app-pda/pilot-link-0.11.7-r1"

MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	if use gnome; then
		mv ${P} ${P}-gpilot
		unpack ${A}
	fi
}

src_compile() {
	# bug #45755
	append-flags -fPIC

	cd ${S}
	econf $(use_enable ssl)
	if use gnome; then
		cd ${S}-gpilot
		econf $(use_enable ssl) --enable-gpilot
	fi

	cd ${S}
	emake || die "make failed"
	if use gnome; then
		cd ${S}-gpilot
		emake || die "gpilot plugin make failed"
	fi

}

src_install() {
	cd ${S}
	make RPM_BUILD_ROOT=${D} install || die "install failed"
	dodoc README INSTALL docs/*

	if use gnome; then
		cd ${S}-gpilot
		insinto /usr/share/gnome-pilot/conduits/
		doins mailsync.conduit
		insinto /usr/lib/gnome-pilot/conduits/
		doins .libs/libgnome_mailsync_conduit.so
	fi

}
