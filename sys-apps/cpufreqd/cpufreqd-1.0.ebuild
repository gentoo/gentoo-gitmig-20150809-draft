# Copyright 1999-2003 Robert Gogolok
# Distributed under the terms of the GNU General Public License v2
# email: robertgogolok@web.de
# ------
# Please email me if you have suggestions how to improve this ebuild
# or when you need help to install it.
DESCRIPTION="Daemon to adjust cpu speed for kernel using the cpufreq patch."
SRC_URI="http://osdn.dl.sourceforge.net/sourceforge/cpufreqd/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/cpufreqd/"
KEYWORDS="x86"
LICENSE="GPL-1"
SLOT="0"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/ \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--sysconfdir=/etc 
	make || die "compile of cpufreqd failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc README Authors TODO
	
	exeinto /etc/init.d
	newexe ${S}/scripts/gentoo/cpufreqd cpufreqd
}
pkg_postinst() {
	einfo "A default config file is copied to /etc/cpufreqd.conf"
}

