# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-1.9.18.ebuild,v 1.2 2005/08/22 16:34:27 swegener Exp $

inherit eutils flag-o-matic

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="mirror://gnupg/alpha/gnupg/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="1.9"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="X caps ldap nls smartcard selinux"

DEPEND="
	nls? ( sys-devel/gettext )
	dev-lang/perl
	sys-libs/zlib
	virtual/libc
	>=dev-libs/pth-1.3.7
	smartcard? ( >=dev-libs/opensc-0.8.0 )
	>=dev-libs/libgcrypt-1.1.94
	>=dev-libs/libksba-0.9.12
	>=dev-libs/libgpg-error-1.0
	=dev-libs/libassuan-0.6.10
	ldap? ( net-nds/openldap )
	caps? ( sys-libs/libcap )"

RDEPEND="
	X? ( || ( media-gfx/xloadimage media-gfx/xli ) )
	virtual/mta
	selinux? ( sec-policy/selinux-gnupg )"



src_unpack() {
	unpack ${A}
	cd ${S}
	if use smartcard && ! built_with_use dev-libs/opensc pcsc-lite ; then
		sed -i -e 's:OPENSC_LIBS="\$OPENSC_LIBS -lpcsclite -lpthread":OPENSC_LIBS="\$OPENSC_LIBS -lopenct -lpthread":' \
		acinclude.m4 || die "openct patching failed."
		./autogen.sh
	fi
	sed -i -e 's/PIC/__PIC__/g' intl/relocatable.c || die "PIC patching failed"
}

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

	use ppc-macos || append-ldflags -Wl,-z,now

	econf \
		--disable-agent \
		--enable-symcryptrun \
		--enable-gpg \
		$(use_enable smartcard scdaemon) \
		$(use_enable nls) \
		$(use_enable ldap) \
		$(use_with caps capabilities) \
		${myconf} \
		|| die
	emake || die
}

src_test() {
	einfo "self tests can't work since it depends on gpg-agent"
	einfo "Gentoo has put this in its own package (app-crypt/gpg-agent"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog INSTALL NEWS README THANKS TODO VERSION

	if ! use caps ; then
		fperms u+s,go-r /usr/bin/gpg2
	fi
}

pkg_postinst() {
	if ! use caps; then
		einfo "gpg is installed suid root to make use of protected memory space"
		einfo "This is needed in order to have a secure place to store your"
		einfo "passphrases, etc. at runtime but may make some sysadmins nervous."
	fi
	echo
	ewarn "** WARNING ** WARNING ** WARNING ** WARNING ** WARNING ** WARNING **"
	ewarn "	THIS IS _ALPHA_ CODE, IT MAY NOT WORK CORRECTLY OR AT ALL. THERE"
	ewarn "	MAY BE UNDISCOVERED SECURITY OR DATA-LOSS ISSUES, DO NOT USE"
	ewarn "	IN A PRODUCTION ENVIRONMENT."
	ewarn
	ewarn "	This ebuild is provided for those who wish to experiment with this"
	ewarn "	new branch of gnupg and beta-testers, not for general purpose use"
	ewarn "	by non-developers"
	ewarn
	ewarn "	Please see #37109"
	ewarn "** WARNING ** WARNING ** WARNING ** WARNING ** WARNING ** WARNING **"

	einfo
	einfo "gpg-agent is now provided in app-crypt/gpg-agent"

	einfo
	einfo "See http://www.gentoo.org/doc/en/gnupg-user.xml for documentation on gnupg"
	einfo
}
