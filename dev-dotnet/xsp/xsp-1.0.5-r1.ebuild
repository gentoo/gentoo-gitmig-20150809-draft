# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/xsp/xsp-1.0.5-r1.ebuild,v 1.1 2005/02/09 03:01:39 latexer Exp $

inherit mono eutils

DESCRIPTION="XSP ASP.NET host"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/archive/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE=""

DEPEND=">=dev-dotnet/mono-${PV}"

pkg_preinst() {
	enewgroup aspnet

	# Give aspnet home dir of /tmp since it must create ~/.wapi
	enewuser aspnet -1 /bin/false /tmp aspnet
}

src_unpack() {
	unpack ${A}
	# Fix for namespace changes in 1.1.x mono
	sed -i "s:Math.Min:System.Math.Min:" ${S}/server/MonoWorkerRequest.cs \
		|| die "sed failed"
}

src_compile() {
	econf || die "./configure failed!"
	emake || {
		echo
		eerror "If xsp fails to build, try unmerging and re-emerging it."
		die "make failed"
	}
}

src_install() {
	make DESTDIR=${D} install || die
	exeinto /etc/init.d ; newexe ${FILESDIR}/xsp.initd xsp
	insinto /etc/conf.d ; newins ${FILESDIR}/xsp.confd xsp

	keepdir /var/run/aspnet

	dodoc README ChangeLog AUTHORS INSTALL NEWS
}

pkg_postinst() {
	chown aspnet:aspnet /var/run/aspnet
}
