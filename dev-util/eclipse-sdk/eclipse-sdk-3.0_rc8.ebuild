# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

inherit eutils

DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://download2.eclipse.org/downloads/drops/S-3.0M8-200403261517/eclipse-sourceBuild-srcIncluded-3.0M8.zip"
LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~x86"

IUSE="gtk2 motif gnome kde"

DEPEND="${RDEPEND}
	>=virtual/jdk-1.3
	>=dev-java/ant-1.4"

RDEPEND="${DEPEND}
	gtk2? ( >=x11-libs/gtk+-2.2.4-r1 )
	motif? ( >=x11-libs/openmotif-2.1.30-r4 ) "



src_unpack() {
	if [ `use gtk2` ] && [ `use motif` ];
	then
		ewarn ""
		einfo "This package cannot be built with gtk2 and motif in USE"
		einfo "Please use only one"
		ewarn ""
		sleep 5
		die
	elif [ ! `use gtk2` ] && [ ! `use motif` ];
	then
		ewarn ""
		einfo "This package needs either gtk2 or motif in USE vars"
		einfo "But never both"
		ewarn ""
		sleep 5
		die
	else
		mkdir ${S}
		cd ${S}
		unpack ${A}
	fi
}

src_compile() {
	if [ `use gtk2` ];
	then
		./build -os linux -ws gtk -arch x86 -target clean
		./build -os linux -ws gtk -arch x86 -target compile
		./build -os linux -ws gtk -arch x86 -target install
	elif [ `use motif` ];
	then
		./build -os linux -ws motif -arch x86 -target clean
		./build -os linux -ws motif -arch x86 -target compile
		./build -os linux -ws motif -arch x86 -target install
	fi
}

src_install() {
	dodir /opt/${P}
	cp -dpR tmp/eclipse/plugins ${D}/opt/${P}
	cp -dpR tmp/eclipse/features ${D}/opt/${P}
	if [ `use gtk2` ];
	then
		cp -dpR tmp/eclipse/linux.gtk.x86/eclipse/* ${D}/opt/${P}
	elif [ `use motif` ];
	then
		cp -dpR tmp/eclipse/linux.motif.x86/eclipse/* ${D}/opt/${P}
	fi
	if use gnome || use kde;
	then
		make_desktop_entry eclipse "Eclipse IDE" /opt/${P}/icon.xpm Development /opt/${P}
	fi
	dodir /etc/env.d
	#the ${FILESDIR}/20eclipse-3.0m7 can be the same in m8
	sed s/eclipse-sdk-3.0/${P}/ < ${FILESDIR}/20eclipse-3.0m7 > ${D}/etc/env.d/20eclipse-3.0m8
}
