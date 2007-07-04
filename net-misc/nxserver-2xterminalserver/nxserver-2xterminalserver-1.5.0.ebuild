# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxserver-2xterminalserver/nxserver-2xterminalserver-1.5.0.ebuild,v 1.6 2007/07/04 15:08:07 voyageur Exp $

inherit flag-o-matic eutils

DESCRIPTION="GPL NX server, based on NoMachine 1.5 servers source code"
HOMEPAGE="http://www.2x.com/terminalserver/"
SRC_URI="http://code.2x.com/release/linuxterminalserver/src/linuxterminalserver-1.5.0-server-r21-src.tar.gz
	http://code.2x.com/release/linuxterminalserver/src/linuxterminalserver-1.5.0-common-r21-src.tar.gz
	http://code.2x.com/release/linuxterminalserver/src/linuxterminalserver-1.5.0-client-r21-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="rdesktop vnc"

RDEPEND="dev-libs/glib
	dev-libs/openssl
	dev-perl/BSD-Resource
	dev-perl/DateManip
	dev-perl/DBD-SQLite
	dev-perl/DBI
	dev-perl/Error
	dev-perl/GDGraph
	dev-perl/Passwd-Linux
	dev-perl/Unix-Syslog
	media-libs/jpeg
	media-libs/libpng
	sys-libs/zlib
	x11-libs/libICE
	x11-libs/libXmu
	x11-libs/libXdmcp
	x11-libs/libSM
	x11-libs/libXt
	x11-libs/libXau
	x11-libs/libXaw
	x11-libs/libXp
	x11-libs/libXpm
	x11-libs/libXext

	media-fonts/font-misc-misc
	media-fonts/font-cursor-misc
	x11-apps/xauth"

DEPEND="${RDEPEND}
	app-text/rman
	net-misc/nxclient-2xterminalserver
	x11-misc/gccmakedep
	x11-misc/imake
	x11-proto/xproto
	x11-proto/xextproto
	x11-proto/fontsproto
	!net-misc/nxserver-freeedition
	!net-misc/nxserver-freenx"

S="${WORKDIR}"

pkg_preinst() {
	enewuser nx -1 -1 /usr/NX/home/nx
}

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/1.5.0/nx-x11-1.5.0-amd64.patch || die
	epatch ${FILESDIR}/1.5.0/nx-x11-1.5.0-plastik-render-fix.patch || die
	epatch ${FILESDIR}/1.5.0/nx-x11-1.5.0-tmp-exec.patch || die
	epatch ${FILESDIR}/1.5.0/nx-x11-1.5.0-xorg7-font-fix.patch || die
	epatch ${FILESDIR}/1.5.0/nx-x11-1.5.0-windows-linux-resume.patch || die

	epatch ${FILESDIR}/1.5.0/${P}-insitu.patch || die
	epatch ${FILESDIR}/1.5.0/${P}-external-nxcomp.patch || die
	epatch ${FILESDIR}/1.5.0/${P}-setup.patch || die
	epatch ${FILESDIR}/1.5.0/${P}-perl.patch || die
	epatch ${FILESDIR}/1.5.0/${P}-nxagent-reduced-debugging.patch || die
	sed -i 's/-Wnested-externs/-Wnested-externs -fPIC/' \
		common/nxcompext/Makefile.in || die "sed failed"

	# Set correct product name
	einfo "Setting official product name"
	find server/nxnode common/nx-X11/programs/Xserver/hw/nxagent/Args.c \
		-type f -exec sed -i "s/@PRODUCT_NAME@/2X TerminalServer/g" {} \;
}

src_compile() {
	cd ${S}/common/nxcompext
	append-ldflags "-L/usr/NX/lib"
	econf || die
	emake || die

	cd ${S}/common/nx-X11
	emake World || die

	if use rdesktop; then
		cd ${S}/client/nxdesktop
		CC=(tc-getCC) ./configure || die
		emake || die
	fi

	if use vnc; then
		cd ${S}/server/nxviewer
		xmkmf -a || die
		emake World || die
	fi

	cd ${S}/server/nxspool/source
	econf --without-ldap --without-krb5 || die
	# We can't use emake here - it doesn't trigger the right target
	# for some reason
	make || die

	cd ${S}/server/nxsensor
	emake || die

	cd ${S}/server/nxuexec
	emake || die

	cd ${S}/server/nxnode/src
	./configure || die
	make setversion
	make nxnode.pl nxserver.pl || die
	perl MakeConfigFile.pl DEBIAN > node-gentoo.cfg.sample
}

src_install() {
	NODE_SRC=${S}/server/nxnode/src

	# Main binaries
	into /usr/NX
	dobin ${S}/common/nx-X11/programs/Xserver/nxagent
	dobin ${S}/server/nxsensor/nxsensor
	dobin ${S}/server/nxnode/setup/nxsetup
	newbin ${S}/server/nxspool/source/bin/smbspool nxspool
	dobin ${S}/server/nxuexec/nxuexec

	if use rdesktop; then
		dobin ${S}/client/nxdesktop/nxdesktop
	fi
	if use vnc; then
		dobin ${S}/server/nxviewer/nxviewer/nxviewer
		dobin ${S}/server/nxviewer/nxpasswd/nxpasswd
	fi

	# Libraries
	dodir /usr/NX/lib
	cp -P ${S}/common/nxcompext/libXcompext.so* \
		${S}/common/nx-X11/lib/X11/libX11.so* ${D}/usr/NX/lib || die
	# And helper scripts
	exeinto /usr/NX/scripts
	newexe ${S}/server/nxnode/bin/nxnodeenv.sh nxenv.sh
	newexe ${S}/server/nxnode/bin/nxnodeenv.csh nxenv.csh
	exeinto /usr/NX/scripts/restricted
	doexe ${S}/server/nxnode/bin/nxaddinitd.sh
	doexe ${S}/server/nxnode/scripts/nxinit.sh
	newexe ${S}/server/nxnode/bin/nxprinter.sh-LINUX nxprinter.sh
	doexe ${S}/server/nxnode/bin/nxsessreg.sh
	doexe ${S}/server/nxnode/bin/nxuseradd.sh

	# The server itself (and wrappers and perl modules)
	dobin ${NODE_SRC}/nxnode.pl
	dobin ${NODE_SRC}/nxserver.pl
	make_wrapper nxnode "perl -I/usr/NX/lib/perl /usr/NX/bin/nxnode.pl" /usr/NX/bin /usr/NX/lib /usr/NX/bin
	make_wrapper nxserver "perl -I/usr/NX/lib/perl /usr/NX/bin/nxserver.pl" /usr/NX/bin /usr/NX/lib /usr/NX/bin

	dodir /usr/NX/lib/perl
	cp -RH ${NODE_SRC}/*.pm ${NODE_SRC}/Config ${NODE_SRC}/Exception \
		${NODE_SRC}/NXShellDialogs ${NODE_SRC}/handlers ${NODE_SRC}/nxstat \
		${D}/usr/NX/lib/perl/ || die

	# etc, var, home, ...
	dodir /usr/NX/etc/keys
	for x in passwords users administrators; do
		cp ${S}/server/nxnode/etc/${x} ${D}/usr/NX/etc/${x}.db.sample
	done
	cp ${NODE_SRC}/node-gentoo.cfg.sample ${D}/usr/NX/etc/ || die

	# share/keys/server.id_dsa.key is installed with the client
	dodir /usr/NX/share/keys
	for x in config fonts keymaps; do
		cp -R ${S}/server/nxnode/share/${x} ${D}/usr/NX/share/ || die
	done
	cp ${S}/server/nxnode/share/keys/default.id_dsa.key \
		${D}/usr/NX/share/keys/ ||die
	cp -R ${S}/server/nxnode/home ${D}/usr/NX || die
	keepdir /usr/NX/var/log
	keepdir /usr/NX/var/run
	keepdir /usr/NX/var/db/closed
	keepdir /usr/NX/var/db/failed
	keepdir /usr/NX/var/db/nxstat
	keepdir /usr/NX/var/db/running
}

pkg_postinst() {
	usermod -s /usr/NX/bin/nxserver nx || die "Unable to set login shell of nx user!!"
	usermod -d /usr/NX/home/nx nx || die "Unable to set home directory of nx user!!"
	# Workaround fonts link
	if has_version '>=x11-base/xorg-x11-7.0' && ! [ -e /usr/lib/X11/fonts ];
	then
		ln -s /usr/share/fonts /usr/lib/X11/fonts
	fi

	# only run install when no configuration file is found
	if [ -f /usr/NX/etc/node.cfg ]; then
		einfo "Running 2X update script"
		${ROOT}/usr/NX/bin/nxsetup --update
	else
		einfo "Running 2X setup script"
		${ROOT}/usr/NX/bin/nxsetup --install
	fi
}
