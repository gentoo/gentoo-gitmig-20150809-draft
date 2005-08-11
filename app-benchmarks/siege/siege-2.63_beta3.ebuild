# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/siege/siege-2.63_beta3.ebuild,v 1.2 2005/08/11 01:48:59 ka0ttic Exp $

inherit eutils bash-completion

MY_P="${P/_beta/b}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A HTTP regression testing and benchmarking utility"
HOMEPAGE="http://www.joedog.org/siege/"
SRC_URI="ftp://sid.joedog.org/pub/${PN}/beta/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~mips ~ppc ~x86"
SLOT="0"
IUSE="ssl"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6d )"
RDEPEND="${DEPEND}
	dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-2.60-gentoo.diff
	sed -i 's/\\b\(Transactions:\)/\1/' src/main.c || \
		die "sed src/main.c failed"
}

src_compile() {
	einfo "Running autoreconf"
	autoreconf || die "autoreconf failed"
	econf $(use_with ssl) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL MACHINES README KNOWNBUGS \
		siegerc-example urls.txt || die "dodoc failed"
	use ssl && dodoc README.https
	dobashcompletion ${FILESDIR}/${PN}.bash-completion ${PN}
}

pkg_postinst() {
	echo
	einfo "An example ~/.siegerc file has been installed as"
	einfo "/usr/share/doc/${PF}/siegerc-example.gz"
	bash-completion_pkg_postinst
}
