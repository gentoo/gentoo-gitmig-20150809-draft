# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gnupg/gnupg-1.9.14.ebuild,v 1.4 2005/01/19 20:26:59 dragonheart Exp $

inherit eutils flag-o-matic

DESCRIPTION="The GNU Privacy Guard, a GPL pgp replacement"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/gnupg/${P}.tar.gz
	idea? ( ftp://ftp.gnupg.dk/pub/contrib-dk/idea.c.gz )"

LICENSE="GPL-2 idea? ( IDEA )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="X caps ldap nls smartcard static idea"

RDEPEND="
	!static? (
		ldap? ( net-nds/openldap )
		caps? ( sys-libs/libcap )
		sys-libs/zlib
	)
	X? ( || ( media-gfx/xloadimage media-gfx/xli ) )
	nls? ( sys-devel/gettext )
	>=dev-libs/libgcrypt-1.1.42
	>=dev-libs/libksba-0.9.7
	smartcard? ( dev-libs/opensc )
	virtual/libc
	dev-lang/perl
	dev-libs/pth
	virtual/mta"
DEPEND="caps? ( sys-libs/libcap )
	ldap? ( net-nds/openldap )
	nls? ( sys-devel/gettext )
	>=dev-libs/libgcrypt-1.1.94
	>=dev-libs/libksba-0.9.7
	>=dev-libs/libassuan-0.6.9
	smartcard? ( dev-libs/opensc )
	sys-libs/zlib
	virtual/libc
	dev-lang/perl
	dev-libs/pth"

src_unpack() {
	unpack ${A}
	# Please read http://www.gnupg.org/why-not-idea.html
	if use idea; then
		mv ${WORKDIR}/idea.c ${S}/cipher/idea.c || \
			ewarn "failed to insert IDEA module"
	fi
	sed -i -e 's/PIC/__PIC__/g' ${S}/intl/relocatable.c
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

	append-ldflags -Wl,-z,now

	econf \
		--disable-agent \
		`use_enable smartcard scdaemon` \
		`use_enable nls` \
		`use_enable ldap` \
		`use_with caps capabilities` \
		${myconf} \
		|| die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dosym gpg2 /usr/bin/gpg

	# keep the documentation in /usr/share/doc/...
	rm -rf "${D}/usr/share/gnupg/FAQ" "${D}/usr/share/gnupg/faq.html"

	dodoc ChangeLog INSTALL NEWS README THANKS TODO VERSION

	if ! use caps ; then
		fperms u+s /usr/bin/gpg2
	fi
}

pkg_postinst() {
	if ! use caps; then
		einfo "gpg is installed suid root to make use of protected memory space"
		einfo "This is needed in order to have a secure place to store your"
		einfo "passphrases, etc. at runtime but may make some sysadmins nervous."
	fi
	if use idea; then
		einfo "you have compiled ${PN} with support for the IDEA algorithm, this code"
		einfo "is distributed under the GPL in countries where it is permitted to do so"
		einfo "by law."
		einfo
		einfo "Please read http://www.gnupg.org/why-not-idea.html for more information."
		einfo
		einfo "If you are in a country where the IDEA algorithm is patented, you are permitted"
		einfo "to use it at no cost for 'non revenue generating data transfer between private"
		einfo "individuals'."
		einfo
		einfo "Countries where the patent applies are listed here"
		einfo "http://www.mediacrypt.com/engl/Content/patent_info.htm"
		einfo
		einfo "Further information and other licenses are availble from http://www.mediacrypt.com/"
	fi
	echo
	ewarn "** WARNING ** WARNING ** WARNING ** WARNING ** WARNING ** WARNING **"
	ewarn "	THIS IS _ALPHA_ CODE, IT MAY NOT WORK CORRECTLY OR AT ALL. THERE"
	ewarn "	MAY BE UNDISCOVERED SECURITY OR DATA-LOSS ISSUES, DO NOT USE "
	ewarn "	IN A PRODUCTION ENVIRONMENT."
	ewarn ""
	ewarn "	This ebuild is provided for those who wish to experiment with this"
	ewarn "	new branch of gnupg and beta-testers, not for general purpose use"
	ewarn "	by non-developers"
	ewarn ""
	ewarn "	Please see #37109"
	ewarn "** WARNING ** WARNING ** WARNING ** WARNING ** WARNING ** WARNING **"

	einfo "gpg-agent is now provided in app-crypt/gpg-agent"

	einfo ""
	einfo "See http://www.gentoo.org/doc/en/gnupg-user.xml for documentation on gnupg"
	einfo ""
}
