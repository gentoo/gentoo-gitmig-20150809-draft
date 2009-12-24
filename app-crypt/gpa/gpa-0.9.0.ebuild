# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpa/gpa-0.9.0.ebuild,v 1.5 2009/12/24 12:16:55 pacho Exp $

EAPI="2"

inherit eutils multilib

DESCRIPTION="The GNU Privacy Assistant (GPA) is a graphical user interface for GnuPG"
HOMEPAGE="http://gpa.wald.intevation.org"
STUPID_NUM="603"
SRC_URI="http://wald.intevation.org/frs/download.php/${STUPID_NUM}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 ~sparc ~x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.10.0
	>=dev-libs/libgpg-error-1.4
	>=dev-libs/libassuan-1.0.4
	>=app-crypt/gnupg-2
	>=app-crypt/gpgme-1.2.0"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.7
	nls? ( sys-devel/gettext )"

src_prepare() {
	sed -i -e 's|gnupg/:|:|g' configure*
}

src_configure() {
	local myconf

	# By default gnupg puts gpgkeys_hkp in /usr/libexec/gnupg, so
	# check if it is in uncommon /usr/lib/gnupg, and change libexecdir
	# if so.  If we do not do this, hkp server types is not usable,
	# as gpa cannot find gpgkeys_hkp ...
	[[ -f /usr/lib/gnupg/gpgkeys_hkp ]] && myconf="--libexecdir=/usr/$(get_libdir)"

	econf \
		--with-gpgme-prefix=/usr \
		--with-libassuan-prefix=/usr \
		$(use_enable nls) \
		${myconf}
	sed -i -e 's|gnupg||g' gpadefs.h
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README NEWS TODO
}
