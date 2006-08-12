# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cogito/cogito-0.17.3.ebuild,v 1.3 2006/08/12 21:08:35 ferdy Exp $

inherit eutils

MY_PV=${PV//_/}

DESCRIPTION="The GIT scripted toolkit"
HOMEPAGE="http://kernel.org/pub/software/scm/cogito/"
SRC_URI="http://kernel.org/pub/software/scm/cogito/${PN}-${MY_PV}.tar.bz2
		mirror://gentoo/${PN}-doc-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-libs/openssl
	sys-libs/zlib
	>=dev-util/git-1.4.0"

RDEPEND="net-misc/rsync
	app-text/rcs
	net-misc/curl"

S=${WORKDIR}/${PN}-${MY_PV}
SDOC=${WORKDIR}/${PN}-doc-${MY_PV}

src_unpack() {
	unpack ${A} ; cd "${S}"

	# t9300-seek won't work under the sandbox
	rm t/t9300-seek.sh
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" prefix="/usr" || die "install failed"
	dodoc README* VERSION COPYING

	doman "${SDOC}"/man?/*

	dodir /usr/share/doc/${PF}/{,html,contrib}
	cp "${SDOC}"/html/* "${D}"/usr/share/doc/${PF}/html
	cp "${S}"/contrib/* "${D}"/usr/share/doc/${PF}/contrib
}

src_test() {
	# 'make test' from the root runs the tutorial-script which executes
	# other commands such as 'gpg' and creates stuff in portage's $HOME.
	cd "${S}"
	make -C t/
}
