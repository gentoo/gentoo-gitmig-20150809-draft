# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/xsp/xsp-1.2.3.ebuild,v 1.1 2007/02/13 19:44:39 jurek Exp $

inherit mono autotools eutils

DESCRIPTION="XSP ASP.NET host"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

DEPEND=">=dev-lang/mono-${PV}"

pkg_preinst() {
	enewgroup aspnet

	# Give aspnet home dir of /tmp since it must create ~/.wapi
	enewuser aspnet -1 -1 /tmp aspnet
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s:mkinstalldirs) \$(data:mkinstalldirs) \$(DESTDIR)\$(data:" \
		-e "s:gif \$(data:gif \$(DESTDIR)\$(data:" \
		${S}/test/2.0/treeview/Makefile.am
	eautoreconf
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
	exeinto /etc/init.d ; newexe ${FILESDIR}/${PV}/xsp.initd xsp
	newexe ${FILESDIR}/${PV}/mod-mono-server.initd mod-mono-server
	insinto /etc/conf.d ; newins ${FILESDIR}/${PV}/xsp.confd xsp
	newins ${FILESDIR}/${PV}/mod-mono-server.confd mod-mono-server

	keepdir /var/run/aspnet

	dodoc README ChangeLog AUTHORS INSTALL NEWS
}

pkg_postinst() {
	chown aspnet:aspnet /var/run/aspnet
}
