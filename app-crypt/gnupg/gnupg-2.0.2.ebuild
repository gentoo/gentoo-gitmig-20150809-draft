# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-2.0.2.ebuild,v 1.1 2007/02/02 14:13:49 alonbl Exp $

inherit eutils flag-o-matic autotools

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="mirror://gnupg/gnupg/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="bzip2 X doc ldap nls openct pcsc-lite smartcard selinux"

COMMON_DEPEND="
	virtual/libc
	>=dev-libs/pth-1.3.7
	>=dev-libs/libgcrypt-1.2.0
	>=dev-libs/libksba-1.0.0
	>=dev-libs/libgpg-error-1.4
	>=dev-libs/libassuan-1.0.1
	bzip2? ( app-arch/bzip2 )
	pcsc-lite? ( >=sys-apps/pcsc-lite-1.3.0 )
	openct? ( >=dev-libs/openct-0.5.0 )
	ldap? ( net-nds/openldap )
	app-crypt/pinentry"

DEPEND="${COMMON_DEPEND}
	nls? ( sys-devel/gettext )
	doc? ( sys-apps/texinfo )"

RDEPEND="${COMMON_DEPEND}
	!app-crypt/gpg-agent
	!<=app-crypt/gnupg-2.0.1
	virtual/mta
	X? ( || ( media-gfx/xloadimage media-gfx/xli ) )
	selinux? ( sec-policy/selinux-gnupg )
	nls? ( virtual/libintl )"

src_compile() {
	local myconf=""

	if use X; then
		local viewer
		if has_version 'media-gfx/xloadimage'; then
			viewer=/usr/bin/xloadimage
		else
			viewer=/usr/bin/xli
		fi
		myconf="${myconf} --with-photo-viewer=${viewer}"
	else
		myconf="${myconf} --disable-photo-viewers"
	fi

	append-ldflags $(bindnow-flags)

	econf \
		--enable-symcryptrun \
		--enable-gpg \
		--enable-gpgsm \
		--enable-agent \
		$(use_enable bzip2) \
		$(use_enable smartcard scdaemon) \
		$(use_enable nls) \
		$(use_enable ldap) \
		--disable-capabilities \
		${myconf} \
		|| die
	emake || die
	if use doc; then
		cd doc
		emake html || die
	fi
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog NEWS README THANKS TODO VERSION

	dosym gpg2 /usr/bin/gpg
	dosym gpgv2 /usr/bin/gpgv
	cp "${D}/usr/share/man/man1/gpg2.1" "${D}/usr/share/man/man1/gpg.1"
	cp "${D}/usr/share/man/man1/gpgv2.1" "${D}/usr/share/man/man1/gpgv.1"

	use doc && dohtml doc/gnupg.html/* doc/*jpg doc/*png
}

