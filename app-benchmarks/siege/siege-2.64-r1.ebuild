# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/siege/siege-2.64-r1.ebuild,v 1.2 2006/12/13 23:45:52 masterdriverz Exp $

inherit eutils bash-completion

DESCRIPTION="A HTTP regression testing and benchmarking utility"
HOMEPAGE="http://www.joedog.org/JoeDog/Siege"
SRC_URI="ftp://sid.joedog.org/pub/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~mips ~ppc ~x86"
SLOT="0"
IUSE="debug ssl"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6d )"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-2.60-gentoo.diff

	# use of \b causes the T in "Transactions" to be displayed
	# on the last column of the previous line.
	sed -i 's/\\b\(Transactions:\)/\1/' src/main.c || \
		die "sed src/main.c failed"

	automake || die "automake failed"
}

src_compile() {
	local myconf
	use ssl && myconf="--with-ssl=/usr" || myconf="--without-ssl"

	econf ${myconf} \
		$(use_with debug debugging) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	# bug 111057 - siege.config utility uses ${} which gets
	# interpreted by bash sending the contents to stderr
	# instead of ${HOME}/.siegerc
	sed -i -e 's|\${}|\\${}|' -e 's|\$(HOME)|\\$(HOME)|' \
		${D}/usr/bin/siege.config

	dodoc AUTHORS ChangeLog INSTALL MACHINES README* KNOWNBUGS \
		siegerc-example urls.txt || die "dodoc failed"
	dobashcompletion ${FILESDIR}/${PN}.bash-completion

	for x in $(find ${D}/usr/bin -name '*.pl') ; do mv "${x}" "${x%.*}" ; done
}

pkg_postinst() {
	echo
	einfo "An example ~/.siegerc file has been installed as"
	einfo "/usr/share/doc/${PF}/siegerc-example.gz"
	bash-completion_pkg_postinst
}
