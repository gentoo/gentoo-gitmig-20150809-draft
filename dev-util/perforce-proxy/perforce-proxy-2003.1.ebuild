# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Proxy daemon for a commercial version control system"
HOMEPAGE="http://www.perforce.com/"
URI_BASE="ftp://ftp.perforce.com/perforce/r03.1/"
BIN_BASE="$URI_BASE/bin.linux24x86"
DOC_BASE="$URI_BASE/doc"
SRC_URI="${BIN_BASE}/p4p"
LICENSE="perforce.pdf"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/glibc"
#RDEPEND=""
S=${WORKDIR}
RESTRICT="nomirror nostrip"
MY_FILES=$FILESDIR/perforce-proxy-2003.1/

src_unpack ()
{
	# we have to copy all of the files from $DISTDIR, otherwise we get
	# sandbox violations when trying to install

	for x in p4p ; do
		cp ${DISTDIR}/$x .
	done
}

src_install()
{
	enewuser perforce
	enewgroup perforce

	dosbin p4p

	fowners perforce:perforce /usr/sbin/p4p

	mkdir -p ${D}/var/log
	touch ${D}/var/log/perforce-proxy
	fowners perforce:perforce /var/log/perforce-proxy

	keepdir /var/cache/perforce-proxy
	fowners perforce:perforce /var/cache/perforce-proxy

	exeinto /etc/init.d
	doexe ${MY_FILES}/init.d/perforce-proxy
	insinto /etc/conf.d
	doins ${MY_FILES}/conf.d/perforce-proxy
}
