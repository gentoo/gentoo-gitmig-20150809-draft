# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/webmin/webmin-1.090.ebuild,v 1.1 2003/05/13 17:47:07 mholzer Exp $

IUSE="ssl"

DESCRIPTION="Webmin, a web-based system administration interface"
SRC_URI="mirror://sourceforge/webadmin/${P}.tar.gz"
HOMEPAGE="http://www.webmin.com/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~ppc ~sparc"

DEPEND="dev-lang/perl
	ssl? ( dev-perl/Net-SSLeay )"

RDEPEND=""

src_install() {
	rm -f mount/freebsd-mounts*
	rm -f mount/openbsd-mounts*
	rm -f mount/macos-mounts*
	(find . -name '*.cgi' ; find . -name '*.pl') | perl perlpath.pl /usr/bin/perl -
	dodir /usr/libexec/webmin
	dodir /etc/init.d
	dodir /var
	dodir /etc/pam.d
	cp -rp * ${D}/usr/libexec/webmin
	mv ${D}/usr/libexec/webmin/openslp/config \
		${D}/usr/libexec/webmin/openslp/config-gentoo-linux
	
	exeinto /etc/init.d
	newexe webmin-gentoo-init webmin

	insinto /etc/pam.d/
	newins webmin-pam webmin
	echo gentoo > ${D}/usr/libexec/webmin/install-type

	exeinto /etc/webmin
	doexe ${FILESDIR}/uninstall.sh

}

pkg_postinst() {
	/etc/init.d/webmin stop >/dev/null 2>&1
	stopstatus=$?
	cd /usr/libexec/webmin
	config_dir=/etc/webmin
	var_dir=/var/webmin
	perl=/usr/bin/perl
	autoos=1
	port=10000
	login=root
	crypt=`grep "^root:" /etc/shadow | cut -f 2 -d :`
	host=`hostname`
	ssl=0
	atboot=0
	nostart=1
	nochown=1
	autothird=1
	nouninstall=1
	noperlpath=1
	export config_dir var_dir perl autoos port login crypt host ssl nochown autothird nouninstall nostart noperlpath
	perl /usr/libexec/webmin/maketemp.pl
	./setup.sh >/tmp/.webmin/webmin-setup.out 2>&1

	if [ "$stopstatus" = "0" ]; then
		# Start if it was running before
		/etc/init.d/webmin start
	fi
}
