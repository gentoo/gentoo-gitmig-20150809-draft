# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpa/gpa-0.7.3.ebuild,v 1.2 2006/08/13 18:52:58 swegener Exp $

DESCRIPTION="Standard GUI for GnuPG"
HOMEPAGE="http://www.gnupg.org/(en)/related_software/gpa/"
SRC_URI="mirror://gnupg/alpha/gpa/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="nls"

DEPEND=">=x11-libs/gtk+-2.2
	>=app-crypt/gnupg-1.2
	>=app-crypt/gpgme-1.1.1
	nls? ( sys-devel/gettext )"

src_compile() {
	myconf=

	# By default gnupg puts gpgkeys_hkp in /usr/libexec/gnupg, so
	# check if it is in uncommon /usr/lib/gnupg, and change libexecdir
	# if so.  If we do not do this, hkp server types is not usable,
	# as gpa cannot find gpgkeys_hkp ...
	[[ -f /usr/lib/gnupg/gpgkeys_hkp ]] && myconf="--libexecdir=/usr/lib"

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
