# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpg-agent/gpg-agent-1.9.14.ebuild,v 1.3 2005/01/07 11:03:55 dragonheart Exp $

inherit eutils flag-o-matic

# gpg-agent is took from gnupg package.
GPG_P=gnupg-${PV}
S=${WORKDIR}/${GPG_P}

DESCRIPTION="The GNU Privacy Guard Agent"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="ftp://ftp.gnupg.org/gcrypt/alpha/gnupg/${GPG_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
# ~arm ~ia64 ~mips ~s390 ~sparce missing until libassuan gets the keywords
# ~alpha missing for dev-libs/libksba-0.9.7

IUSE="nls caps threads"

RDEPEND="app-crypt/gnupg
	nls? ( sys-devel/gettext )
	virtual/libc
	>=dev-libs/libassuan-0.6.9
	caps? ( sys-libs/libcap )
	>=dev-libs/libgpg-error-0.7
	>=dev-libs/libgcrypt-1.1.94
	>=dev-libs/libksba-0.9.7
	threads? ( dev-libs/pth )"

DEPEND="${RDEPEND}
	dev-lang/perl
	sys-apps/sed"

src_unpack() {
	unpack ${A}
	sed -e 's:GNUPG_LIBEXECDIR:"/usr/lib/gnupg":' -i ${S}/g10/keyserver.c
}

src_compile() {

	append-ldflags -Wl,-z,now
	econf \
		--libexecdir=/usr/lib \
		--enable-agent-only \
		`use_with caps capabilities` \
		`use_enable threads` \
		|| die

	emake || die
}

src_test() {
	einfo "self test is broken"
}

src_install() {
	cd ${S}
	emake DESTDIR=${D} libexecdir="/usr/lib/gnupg" install || die

	# keep the documentation in /usr/share/doc/...
	rm -rf "${D}/usr/share/gnupg/FAQ" "${D}/usr/share/gnupg/faq.html"

	dodoc README

	if ! use caps ; then
		fperms u+s /usr/bin/gpg-agent
	fi
}

pkg_postinst() {

	ewarn "** WARNING ** WARNING ** WARNING ** WARNING ** WARNING ** WARNING **"
	ewarn " THIS IS _ALPHA_ CODE, IT MAY NOT WORK CORRECTLY OR AT ALL. THERE"
	ewarn " MAY BE UNDISCOVERED SECURITY OR DATA-LOSS ISSUES, DO NOT USE "
	ewarn " IN A PRODUCTION ENVIRONMENT."

	if ! use caps; then
		einfo "gpg is installed suid root to make use of protected memory space"
		einfo "This is needed in order to have a secure place to store your"
		einfo "passphrases, etc. at runtime but may make some sysadmins nervous."
	fi
	echo
}
