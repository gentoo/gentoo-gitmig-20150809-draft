# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Daemon for a commercial version control system"
HOMEPAGE="http://www.perforce.com/"
URI_BASE="ftp://ftp.perforce.com/perforce/r03.1/"
BIN_BASE="$URI_BASE/bin.linux24x86"
DOC_BASE="$URI_BASE/doc"
SRC_URI="${BIN_BASE}/p4d ${BIN_BASE}/p4web ${BIN_BASE}/p4ftpd ${DOC_BASE}/man/p4d.1"
LICENSE="perforce.pdf"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/glibc"
#RDEPEND=""
S=${WORKDIR}
RESTRICT="nomirror nostrip"
MY_FILES=$FILESDIR/perforce-2003.1/

src_unpack ()
{
	# we have to copy all of the files from $DISTDIR, otherwise we get
	# sandbox violations when trying to install

	for x in p4web p4d p4ftpd p4d.1 ; do
		cp ${DISTDIR}/$x .
	done
}

src_install()
{
	enewuser perforce
	enewgroup perforce

	dosbin p4d
	dosbin p4web
	dosbin p4ftpd

	fowners perforce:perforce /usr/sbin/p4d
	fowners perforce:perforce /usr/sbin/p4ftpd
	fowners perforce:perforce /usr/sbin/p4web

	mkdir -p ${D}/var/log
	touch ${D}/var/log/perforce
	fowners perforce:perforce /var/log/perforce

	doman p4d.1

	keepdir /var/lib/perforce
	fowners perforce:perforce /var/lib/perforce

	exeinto /etc/init.d
	doexe ${MY_FILES}/init.d/perforce
	insinto /etc/conf.d
	doins ${MY_FILES}/conf.d/perforce
	insinto /etc/env.d
	doins ${MY_FILES}/50perforce
}
