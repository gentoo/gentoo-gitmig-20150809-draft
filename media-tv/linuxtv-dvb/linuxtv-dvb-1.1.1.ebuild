# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/linuxtv-dvb/linuxtv-dvb-1.1.1.ebuild,v 1.3 2004/11/18 00:00:08 chriswhite Exp $

inherit eutils kmod

DESCRIPTION="Standalone DVB driver for Linux kernel 2.4.x"
HOMEPAGE="http://www.linuxtv.org"
SRC_URI="http://www.linuxtv.org/download/dvb/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ia64 ~amd64 ~ppc"
IUSE=""
DEPEND="virtual/linux-sources"
#RDEPEND=""

pkg_setup() {
	einfo ""
	einfo "Please make sure that the following option is enabled"
	einfo "in your current kernel 'Multimedia devices'"
	einfo "and /usr/src/linux point's to your current kernel"
	einfo "or make will die."
	einfo ""
}

src_compile() {
	# don't interfere with the kernel arch variables
	unset ARCH

	#until kmod can be fudged for 
	#this to not have to be included
	addwrite /usr/src/linux

	emake
}

src_install() {
	# see what kernel directory we need to
	# go to
	get_kernel_info
	if is_kernel 2 6
	then
		cd ${S}/build-2.6
	else
		cd ${S}/build-2.4
	fi

	#copy over the insmod.sh script
	#for loading all modules
	sed -e "s:insmod ./:modprobe :" -i insmod.sh
	sed -e "s:.${KV_OBJ}::" -i insmod.sh
	newsbin insmod.sh dvb-module-load

	#install the modules
	insinto /lib/modules/${KV}/misc
	doins *.${KV_OBJ}

	#install the header files
	cd ${S}/linux/include/linux/dvb
	insinto /usr/include/linux/dvb
	doins *.h

	#note, REAME-2.6 is an alternative method
	#of installing dvb besides the ebuild.
	#since this ebuild is being installed (obviously)
	#there is no nead for the information contained
	#within it.  If you want to use the README-2.6
	#method, please get a source tarball, as it will
	#not be supported - ChrisWhite

	#install the main docs
	cd ${S}
	dodoc MAKEDEV-DVB.sh NEWS README README.bt8xx TODO TROUBLESHOOTING

	#install the other docs
	cd ${S}/doc
	dodoc HOWTO-use-the-demux-api \
	README.valgrind HOWTO-use-the-frontend-api \
	convert.sh valgrind-2.1.0-dvb.patch
}

pkg_postinst() {
	depmod -a
	einfo ""
	einfo "If you don't use devfs, execute MAKEDEV-DVB.sh to create"
	einfo "the device nodes. The file is in /usr/share/doc/${PF}/"
	einfo ""
	einfo "A file called dvb-module-load has been created to simplify loading all modules."
	einfo "Call it using 'dvb-module-load {load|debug|unload}'."
}

pkg_postrm() {
	depmod -a
}
