# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/putty/putty-0.60_p20100131.ebuild,v 1.7 2011/02/21 06:55:25 phajdan.jr Exp $

EAPI="2"

inherit autotools eutils toolchain-funcs

DESCRIPTION="UNIX port of the famous Telnet and SSH client"
HOMEPAGE="http://www.chiark.greenend.org.uk/~sgtatham/putty/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="MIT"

SLOT="0"
KEYWORDS="~alpha amd64 ~ppc ~sparc x86"
IUSE="doc ipv6 kerberos"

RDEPEND="
	x11-libs/gtk+:2
	kerberos? ( virtual/krb5 )
	!net-misc/pssh
"
DEPEND="${RDEPEND} dev-lang/perl"

S="${WORKDIR}/putty-0.60-2010-01-31"

src_prepare() {
	cd "${S}"/unix || die "cd unix failed"
	sed \
		-i configure.ac \
		-e '/^AM_PATH_GTK(/d' \
		-e 's|-Wall -Werror||g' || die "sed failed"
	eautoreconf
}

src_configure() {
	cd "${S}"/unix || die "cd failed"
	econf \
		$(use_with kerberos gssapi) \
		|| die "econf failed"
}

src_compile() {
	cd "${S}"/unix || die "cd unix failed"
	emake \
		$(use ipv6 || echo COMPAT=-DNO_IPV6) \
		VER=-DSNAPSHOT=${PV} \
		|| die "emake failed"
}

src_install() {
	if use doc; then
		dodoc doc/puttydoc.txt || die "dodoc failed"
		dohtml doc/*.html || die "dohtml failed"
	fi

	cd "${S}"/unix
	emake DESTDIR="${D}" install || die "install failed"

	# install desktop file provided by Gustav Schaffter in #49577
	doicon "${FILESDIR}"/${PN}.xpm
	make_desktop_entry "putty" "PuTTY" putty "Network"
}
