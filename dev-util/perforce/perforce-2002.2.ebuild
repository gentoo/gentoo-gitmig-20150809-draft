# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/perforce/perforce-2002.2.ebuild,v 1.2 2004/01/14 00:27:07 stuart Exp $

DESCRIPTION="Commercial version control system"
HOMEPAGE="http://www.perforce.com/"
URI_BASE="ftp://ftp.perforce.com/perforce/r02.2/"
BIN_BASE="$URI_BASE/bin.linux24x86"
DOC_BASE="$URI_BASE/doc"
SRC_URI="$BIN_BASE/p4d $BIN_BASE/p4 $BIN_BASE/p4web $BIN_BASE/p4ftpd $BIN_BASE/p4p $DOC_BASE/man/p4.1 $DOC_BASE/man/p4d.1"
LICENSE="perforce.pdf"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="virtual/glibc"
#RDEPEND=""
S=${WORKDIR}
RESTRICT="nomirror nostrip"
MY_FILES=$FILESDIR/perforce-2002.2/

src_unpack ()
{
	# we have to copy all of the files from $DISTDIR, otherwise we get
	# sandbox violations when trying to install

	for x in p4 p4web p4d p4ftpd p4p p4.1 p4d.1 ; do
		cp ${DISTDIR}/$x .
	done
}

src_install()
{
	enewuser perforce
	enewgroup perforce

	dobin  p4
	dosbin p4d
	dosbin p4web
	dosbin p4p
	dosbin p4ftpd

	fowners perforce:perforce /usr/sbin/p4d
	fowners perforce:perforce /usr/sbin/p4p
	fowners perforce:perforce /usr/sbin/p4ftpd
	fowners perforce:perforce /usr/sbin/p4web

	doman p4.1 p4d.1

	keepdir /var/lib/perforce
	fowners perforce:perforce /var/lib/perforce

	exeinto /etc/init.d
	doexe ${MY_FILES}/init.d/perforce
	insinto /etc/conf.d
	doins ${MY_FILES}/conf.d/perforce
	insinto /etc/env.d
	doins ${MY_FILES}/50perforce
}
