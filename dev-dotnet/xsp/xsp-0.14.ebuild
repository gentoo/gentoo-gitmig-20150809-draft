# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/xsp/xsp-0.14.ebuild,v 1.2 2004/06/02 21:51:20 dholm Exp $

inherit mono

DESCRIPTION="XSP ASP.NET host"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/archive/beta2/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND=">=dev-dotnet/mono-0.91"

src_compile() {
	econf || die "./configure failed!"
	emake || {
		echo
		eerror "If xsp fails to build, try unmerging and re-emerging it."
		die "make failed"
	}
}

src_install() {
	enewgroup aspnet

	# Give aspnet home dir of /tmp since it must create ~/.wapi
	enewuser aspnet -1 /bin/false /tmp aspnet

	einstall DESTDIR=${D} || die
	exeinto /etc/init.d ; newexe ${FILESDIR}/xsp.initd xsp
	insinto /etc/conf.d ; newins ${FILESDIR}/xsp.confd xsp

	keepdir /var/run/aspnet

	dodoc README ChangeLog AUTHORS INSTALL NEWS
}

pkg_postinst() {
	chown aspnet:aspnet /var/run/aspnet
}
