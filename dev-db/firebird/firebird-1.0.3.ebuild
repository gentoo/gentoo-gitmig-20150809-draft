# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/firebird/firebird-1.0.3.ebuild,v 1.2 2003/06/22 16:07:19 mksoft Exp $

S=${WORKDIR}/interbase
DESCRIPTION="A relational database offering many ANSI SQL-92 features"
SRC_URI="mirror://sourceforge/${PN}/FirebirdCS-1.0.3.972-0.tar.gz
	mirror://sourceforge/${PN}/Firebird-1.0.3.972.src.tar.gz"
HOMEPAGE="http://firebird.sourceforge.net/"
SLOT="0"
LICENSE="MPL-1.1"
KEYWORDS="~x86"
DEPEND="app-shells/bash
	app-arch/zip
	>=sys-devel/gcc-2.95.3-r5"

src_unpack() {
	unpack FirebirdCS-1.0.3.972-0.tar.gz
	cd ${WORKDIR}
	unpack Firebird-1.0.3.972.src.tar.gz
	cd ${WORKDIR}/FirebirdCS-1.0.3.972-0
	tar xzf buildroot.tar.gz

	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-gentoo.patch
}

src_compile() {
	export INTERBASE="${WORKDIR}/FirebirdCS-1.0.3.972-0/opt/interbase/"
	export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$INTERBASE/lib"
	export FIREBIRD_64_BIT_IO="1"
	export NOPROMPT_SETUP="1"
	export GENTOO_CFLAGS=$CFLAGS
	./Configure.sh PROD || die
	cd ${S}/interbase/lib
	ln -s gds.so libgds.so
	cd ${S}
	source Configure_SetupEnv.sh
	make LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$INTERBASE/lib" firebird || die
	make classictarfile || die
}

src_install () {
	dodoc README
	cd ${D}
	tar xzpf ${S}/FirebirdCS-1.0.3.972-0.64IO/buildroot.tar.gz
	insinto /etc/xinetd.d ; newins ${FILESDIR}/firebird.xinetd firebird
	insinto /etc/env.d ; doins ${FILESDIR}/70firebird

	# kill lingering gds_lock_mgr processes - bug #15071
	kill `ps aux | grep gds_lock_mgr | grep '/var/tmp/portage' | awk '{print $2}'`
	# move isc4.gdb and isc_config to /etc/firebird and have them
	# protected by CONFIG_PTROTECT
	dodir /etc/firebird
	mv ${D}/opt/interbase/{isc4.gdb,isc_config} ${D}/etc/firebird
	dosym /etc/firebird/isc4.gdb /opt/interbase/isc4.gdb
	dosym /etc/firebird/isc_config /opt/interbase/isc_config

	# check for old isc4.gdb from old 1.0 firebird installation. We need it
	# so it installation won't overwrite original
	if [ ! -L /opt/interbase/isc4.gdb ]
	then
	  cp /opt/interbase/isc4.gdb ${D}/etc/firebird/isc4.gdb
	fi
}

pkg_postinst() {
	einfo
	einfo "If not done already, please execute the command"
	einfo "\"ebuild /var/db/pkg/dev-db/${PF}/${PF}.ebuild config\"	"
	einfo "to add gds_db to /etc/services" 
	einfo
}

pkg_config() {
	echo -e "#\n#Service added for gds_db (firebird)\n#" >> /etc/services
	echo "gds_db		3050/tcp" >> /etc/services

	einfo "added gds_db to /etc/services"
}
