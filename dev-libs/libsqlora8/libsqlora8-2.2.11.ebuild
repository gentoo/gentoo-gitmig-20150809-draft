# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libsqlora8/libsqlora8-2.2.11.ebuild,v 1.1 2004/02/13 02:50:48 rizzo Exp $

IUSE="pthreads orathreads"

DESCRIPTION="libsqlora8 is a simple C-library to access Oracle databases via the OCI interface"
SRC_URI="http://www.poitschke.de/libsqlora8/${P}.tar.gz"
HOMEPAGE="http://www.poitschke.de/libsqlora8/index_noframe.html"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"

DEPEND=""

pkg_setup() {
	if [ `use orathreads` -a `use pthreads` ]; then
		eerror
		eerror 'Enable the "pthreads" USE flag for POSIX threads,'
		eerror '*or* the "orathreads" USE flag for Oracle threads'
		eerror
		die 'Both "pthreads" and "orathreads" USE flags set, see above'
	fi

	# Make sure ORACLE_HOME is set
	if [ -z $ORACLE_HOME ]; then
		eerror
		eerror 'libsqlora8 requires that the ORACLE_HOME environment variable be set.'
		eerror 'Try: "export ORACLE_HOME=/usr/local/oracle" if you do not know what to do.'
		eerror
		die 'ORACLE_HOME not set, see above'
	fi

	# Add $ORACLE_HOME/lib to LD_LIBRARY_PATH
	if [ -z $LD_LIBRARY_PATH ]; then
	  LD_LIBRARY_PATH=$ORACLE_HOME/lib
	else
	  LD_LIBRARY_PATH=$ORACLE_HOME/lib:$LD_LIBRARY_PATH
	fi
	export LD_LIBRARY_PATH
}

src_compile() {
	local myconf;

	use pthreads && myconf="--with-threads=posix"
	use orathreads && myconf="--with-threads=oracle"

	# Build
	econf $myconf || die "configure failed"
	emake
	#make "DESTDIR=${D}" "docdir=${D}/usr/share/doc/${P}" || die "make failed"
}

src_install () {
	einstall
	dodoc COPYING ChangeLog INSTALL NEWS NEWS-2.2
	#mv ${D}/usr/share/doc/packages/${PN} ${D}/usr/share/doc/${P}

	# TODO
	# Copy contents of doc and examples directory to doc
}
