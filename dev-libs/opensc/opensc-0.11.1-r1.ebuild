# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/opensc/opensc-0.11.1-r1.ebuild,v 1.1 2006/12/02 17:23:42 alonbl Exp $

inherit eutils libtool autotools

DESCRIPTION="SmartCard library and applications"
HOMEPAGE="http://www.opensc-project.org/opensc/"
SRC_URI="http://www.opensc-project.org/files/opensc/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="pcsc-lite openct"

RDEPEND="dev-libs/openssl
	sys-libs/zlib
	openct? ( >=dev-libs/openct-0.5.0 )
	pcsc-lite? ( >=sys-apps/pcsc-lite-1.3.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	EPATCH_SINGLE_MSG="Applying libtool reverse deps patch ..." \
		epatch ${ELT_PATCH_DIR}/fix-relink/1.5.0

	epatch "${FILESDIR}/${P}-dep.patch"

	AT_M4DIR="aclocal" eautoreconf
}

src_compile() {
	# --without-plugin-dir generates a /no directory
	econf \
		--with-plugin-dir=/usr/lib/mozilla/plugins \
		$(use_enable openct) \
		$(use_enable pcsc-lite) \
		|| die

	emake -j1 || die
}

src_install() {
	make install DESTDIR="${D}" || die

	dodoc NEWS README
	dohtml doc/*.{html,css}

	insinto /etc
	doins etc/opensc.conf
}

pkg_postinst() {
	ewarn "If you are upgrading from < opensc-0.10.0, be advised"
	ewarn "that some functionality that was previously provided"
	ewarn "by opensc is now packaged separately."
	ewarn "check out sys-auth/pam_pkcs11, sys-auth/pam_p11 and"
	ewarn "dev-libs/engine_pkcs11 since you might need them."
	ewarn "Also in case of an upgrade please remember to run"
	ewarn "revdep-rebuild due to ABI breakage."
}
