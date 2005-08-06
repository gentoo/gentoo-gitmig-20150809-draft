# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/gpg-agent/gpg-agent-1.9.16.ebuild,v 1.5 2005/08/06 05:31:05 dragonheart Exp $

inherit eutils flag-o-matic

# gpg-agent is took from gnupg package.
GPG_P=gnupg-${PV}
S=${WORKDIR}/${GPG_P}

DESCRIPTION="The GNU Privacy Guard Agent"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="mirror://gnupg/alpha/gnupg/${GPG_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"

IUSE="caps nls smartcard threads"

RDEPEND="app-crypt/gnupg
	nls? ( sys-devel/gettext )
	>=dev-libs/libassuan-0.6.9
	caps? ( sys-libs/libcap )
	>=dev-libs/libgpg-error-1.0
	>=dev-libs/libgcrypt-1.1.94
	>=dev-libs/libksba-0.9.7
	smartcard? ( >=dev-libs/opensc-0.8.0 )
	threads? ( >=dev-libs/pth-1.3.7 )"
DEPEND="${RDEPEND}
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# We install +s only if USE=-caps
	use caps && return 0
	sed -i \
		-e '/^gpg_agent_LDADD/s:=:=-Wl,-z,now:' \
		agent/Makefile.in || die "sed -z now"
}

src_compile() {
	econf \
		--enable-agent-only \
		$(use_with caps capabilities) \
		$(use_enable threads) \
		|| die
	emake || die
}

src_test() {
	ewarn "self test is broken"
}

src_install() {
	make DESTDIR="${D}" install || die

	# keep the documentation in /usr/share/doc/...
	rm -f "${D}"/usr/share/gnupg/FAQ "${D}"/usr/share/gnupg/faq.html
	dodoc README

	if ! use caps ; then
		fperms u+s,go-r /usr/bin/gpg-agent
	fi
}

pkg_postinst() {
	ewarn "** WARNING ** WARNING ** WARNING ** WARNING ** WARNING ** WARNING **"
	ewarn " THIS IS _ALPHA_ CODE, IT MAY NOT WORK CORRECTLY OR AT ALL. THERE"
	ewarn " MAY BE UNDISCOVERED SECURITY OR DATA-LOSS ISSUES, DO NOT USE"
	ewarn " IN A PRODUCTION ENVIRONMENT."

	if ! use caps; then
		einfo "gpg is installed suid root to make use of protected memory space"
		einfo "This is needed in order to have a secure place to store your"
		einfo "passphrases, etc. at runtime but may make some sysadmins nervous."
	fi
	echo
}
