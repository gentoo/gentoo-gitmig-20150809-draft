# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/psi/psi-0.8.6.ebuild,v 1.4 2002/08/25 16:12:16 danarmak Exp $

S=${WORKDIR}/${P}
QV="1.0"
SRC_URI="http://psi.affinix.com/files/${PV}/${P}.tar.bz2
	http://psi.affinix.com/files/common/qssl-${QV}.tar.bz2"
DESCRIPTION="QT 3.x Jabber Client, with Licq-like interface"
HOMEPAGE="http://www.affinix.com/~justin/programs/psi/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=x11-libs/qt-3
	ssl? ( >=dev-libs/openssl-0.9.6c )"

src_compile() {
	
	export QTDIR="${QTDIR}"
	export QMAKESPEC="linux-g++"
	cd ${S}/src
	mv common.cpp common.cpp.orig
	sed -e 's:return "/usr/local/psi":return "/usr/share/psi":' common.cpp.orig | cat > common.cpp
	/usr/qt/3/bin/qmake psi.pro || die
	emake CFLAGS="${CFLAGS} -D_REENTRANT  -DQT_NO_DEBUG -DQT_THREAD_SUPPORT" CXXFLAGS="${CXXFLAGS} -D_REENTRANT  -DQT_NO_DEBUG -DQT_THREAD_SUPPORT" || die
	mv psi ${S}
	if [ "`use ssl`" ]; then
		cd ${WORKDIR}/qssl-${QV}
		qmake qssl.pro
  		make
	fi
}

src_install() {

	# We do not use the ./install method, we do it manually ##
	
	export PSIDIR=/usr/share/psi
	
	mkdir -p ${D}/usr/bin
	mkdir -p ${D}/usr/share/psi
	#mkdir -p ${D}/usr/share/psi/iconsets

	cd ${S}
	cp -rf ./image ${D}/usr/share/psi/
	cp -rf ./iconsets ${D}/usr/share/psi/
	cp -rf ./sound ${D}/usr/share/psi/
	cp -rf ./certs ${D}/usr/share/psi/
	if [ "`use ssl`" ]; then
                cd ${WORKDIR}/qssl-${QV}
                cp libqssl.so ${D}/usr/share/psi
		cd ${S}
        fi

	cp psi ${D}/usr/share/psi/
	cp README ${D}/usr/share/psi/
	cp COPYING ${D}/usr/share/psi/
	ln -sf /usr/share/psi/psi ${D}/usr/bin/psi

}
