# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/dcc/dcc-1.2.28.ebuild,v 1.2 2004/03/29 01:12:51 vapier Exp $

DESCRIPTION="Distributed Checksum Clearinghouse"
HOMEPAGE="http://www.rhyolite.com/anti-spam/dcc/"
MY_P="dcc-dccd-${PV}"
SRC_URI="${HOMEPAGE}/source/${MY_P}.tar.Z"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="dev-lang/perl
	net-mail/procmail
	|| ( net-misc/wget net-www/fetch net-misc/curl net-ftp/ftp )
	virtual/glibc"
DEPEND="sys-apps/sed
	sys-devel/gcc
	${RDEPEND}"

S=${WORKDIR}/${MY_P}

dcc_cgibin=/var/www/localhost/cgi-bin/dcc
dcc_homedir=/var/dcc
dcc_libexec=/usr/sbin
dcc_man=/usr/share/man
dcc_rundir=/var/run/dcc

src_compile() {
	local myconf
	myconf="${myconf} --homedir=${dcc_homedir}"
	myconf="${myconf} --libexecdir=${dcc_libexec}"
	myconf="${myconf} --bindir=/usr/bin"
	myconf="${myconf} --mandir=/usr/share/man"
	myconf="${myconf} --with-cgibin=${dcc_cgibin}"
	myconf="${myconf} --disable-dccm"
	#myconf="${myconf} --without-cgibin"
	myconf="${myconf} --with-rundir=/var/run/dcc"
	myconf="${myconf} `use_enable ipv6 IPv6`"
	./configure ${myconf} || die "econf failed!"
	#make -C homedir
	emake || die "emake failed!"
}

moveconf() {
	for i in $@; do
		local into=/etc/dcc/
		local from=/var/dcc/
		mv ${D}${from}${i} ${D}${into}
		dosym ${into}${i} ${from}${i}
	done
}

src_install() {
	# stolen from the RPM .spec and modified for gentoo
	MANOWN=root MANGRP=root export MANOWN MANGRP
	BINOWN=$MANOWN BINGRP=$MANGRP export BINOWN BINGRP
	DCC_PROTO_HOMEDIR=${D}${dcc_homedir} export DCC_PROTO_HOMEDIR
	DCC_CGIBINDIR=${D}${dcc_cgibin} export DCC_CGIBINDIR
	DCC_SUID=$BINOWN DCC_OWN=$BINOWN DCC_GRP=$BINGRP export DCC_SUID DCC_OWN DCC_GRP

	dodir /etc/cron.daily ${dcc_homedir} ${dcc_cgibin} /usr/bin /usr/sbin /usr/share/man/man{0,8} /etc/dcc
	keepdir /var/run/dcc /var/log/dcc

	make DESTDIR=${D} DCC_BINDIR=${D}/usr/bin MANDIR=${D}/usr/share/man/man install || die

	einfo "Branding and setting reasonable defaults"
	sed -e "s/BRAND=\$/BRAND='Gentoo ${PF}'/;" \
		-e "s/DCCM_LOG_AT=5\$/DCCM_LOG_AT=50/;" \
		-e "s,DCCM_LOGDIR=log\$,DCCM_LOGDIR=/var/log/dcc,;" \
		-e "s/DCCM_ARGS=\$/DCCM_ARGS='-SHELO -Smail_host -SSender -SList-ID'/;" \
		-e "s/DCCIFD_ARGS=\$/DCCIFD_ARGS=\"\$DCCM_ARGS\"/;" \
		-e 's/DCCIFD_ENABLE=off/DCCIFD_ENABLE=on/' \
		-i ${D}${dcc_homedir}/dcc_conf

	einfo "Providing cronjob"
	mv ${D}/usr/bin/cron-dccd ${D}/etc/cron.daily/dccd

	einfo "Puting system code in sbin instead of bin"
	mv ${D}/usr/bin/{dbclean,dblist,dccd,dccsight,refeed,start-dccd,stop-dccd,wlist,dcc-stats-graph,newwebuser,dcc-stats-init,stats-get,dcc-stats-collect,dccifd,start-grey,start-dccifd,fetch-testmsg-whitelist} ${D}/usr/sbin/

	einfo "Cleaning up"
	rm -f ${D}/usr/bin/{logger,hackmc,na-spam,ng-spam,rcDCC,start-dccm,updatedcc}

	einfo "Placing configuration files into /etc instead of /var/run"
	moveconf dcc_conf flod grey_flod grey_whitelist ids map.txt whiteclnt whitecommon whitelist

	rmdir ${D}/var/dcc/log/
}
