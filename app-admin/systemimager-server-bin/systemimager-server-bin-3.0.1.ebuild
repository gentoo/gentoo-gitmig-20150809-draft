# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/systemimager-server-bin/systemimager-server-bin-3.0.1.ebuild,v 1.4 2004/05/31 19:21:33 vapier Exp $

MY_P="systemimager-server-3.0.1-4.noarch"

DESCRIPTION="System imager server. Software that automates Linux installs, software distribution, and production deployment."
HOMEPAGE="http://www.systemimager.org/"
SRC_URI="mirror://sourceforge/systemimager/${MY_P}.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="app-arch/rpm2targz
	app-admin/systemimager-common-bin
	app-admin/systemimager-boot-bin
	app-admin/systemconfigurator"
RDEPEND="${DEPEND}
	dev-perl/AppConfig
	dev-perl/XML-Simple"

S=${WORKDIR}

src_unpack() {
	rpm2targz ${DISTDIR}/${MY_P}.rpm || die
	tar zxf ${WORKDIR}/${MY_P}.tar.gz || die
}

src_compile() {
	einfo "nothing to compile; binary package."
}

src_install() {
	dobin usr/bin/{mkautoinstallcd,mkautoinstalldiskette} || die
	dodir /usr/lib/systemimager/perl/SystemImager/
	insinto /usr/lib/systemimager/perl/SystemImager/
	doins usr/lib/systemimager/perl/SystemImager/Server.pm || die
	dosbin usr/sbin/{addclients,cpimage,getimage,mkautoinstallscript,mkbootserver,mkclientnetboot,mkdhcpserver,mkdhcpstatic,mkrsyncd_conf,mvimage,netbootmond,pushupdate,rmimage} || die
	doman usr/share/man/man5/*.gz
	doman usr/share/man/man8/*.gz
	dodoc usr/share/doc/systemimager-server-3.0.1/*

	dodir /var/lib/systemimager/{images,overrides,scripts}
	insinto /var/lib/systemimager/images
	doins var/lib/systemimager/images/* || die
	dodir /var/log/systemimager

	exeinto /etc/init.d
	doexe etc/init.d/* || die
	dodir /etc/system/imager/{pxelinux.cfg,rsync_stubs}
	insinto /etc/systemimager/pxelinux.cfg
	doins etc/systemimager/pxelinux.cfg/* || die
	insinto /etc/systemimager/rsync_stubs
	doins etc/systemimager/rsync_stubs/* || die
	insinto /etc/systemimager
	doins etc/systemimager/systemimager.conf || die
}
