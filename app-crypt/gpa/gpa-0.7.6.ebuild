# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpa/gpa-0.7.6.ebuild,v 1.6 2008/04/27 03:43:04 drac Exp $

inherit eutils multilib

DESCRIPTION="Standard GUI for GnuPG"
HOMEPAGE="http://gpa.wald.intevation.org"
STUPID_NUM="350"
SRC_URI="http://wald.intevation.org/frs/download.php/${STUPID_NUM}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ~ppc64 sparc x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.2
	>=app-crypt/gnupg-1.2
	>=app-crypt/gpgme-1.1.1"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.7
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-qa.patch"
}

src_compile() {
	local myconf=

	# By default gnupg puts gpgkeys_hkp in /usr/libexec/gnupg, so
	# check if it is in uncommon /usr/lib/gnupg, and change libexecdir
	# if so.  If we do not do this, hkp server types is not usable,
	# as gpa cannot find gpgkeys_hkp ...
	[ -f /usr/lib/gnupg/gpgkeys_hkp ] && myconf="--libexecdir=/usr/$(get_libdir)"

	econf \
		--with-gpgme-prefix=/usr \
		$(use_enable nls) \
		${myconf} \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README NEWS TODO
}
