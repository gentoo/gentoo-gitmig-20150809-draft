# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kmm_banking/kmm_banking-0.9.9.ebuild,v 1.2 2009/01/17 14:58:34 tgurr Exp $

EAPI="2"
ARTS_REQUIRED="never"
inherit kde

DESCRIPTION="KMyMoney2 HBCI plugin utilizing AqBanking."
HOMEPAGE="http://www.aquamaniac.de/sites/download/packages.php?package=05&showall=1"
SRC_URI="http://www.aquamaniac.de/sites/download/download.php?package=05&release=07&file=01&dummy=${P}beta.tar.gz -> ${P}beta.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=app-office/kmymoney2-0.9.2
	>=net-libs/aqbanking-3.8.1[hbci,kde,qt3]
	>=sys-libs/gwenhywfar-3.5.2"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}beta"

need-kde 3.5

src_prepare() {
	cd "${S}"
	sed -i -e 's/kde_libraries/libdir/g' \
		"${S}"/src/Makefile.am || die "sed failed"

	rm "${S}"/configure

# eapi2 eclass workaround start
	if [[ -f admin/cvs.sh ]]; then
		sed -i -e '/case $AUTO\(CONF\|HEADER\)_VERSION in/,+1 s/2\.5/2.[56]/g' \
			admin/cvs.sh
	fi
	# Replace the detection script with a dummy, let our wrappers do the work
	if [[ -f admin/detect-autoconf.sh ]]; then
		cat - > admin/detect-autoconf.sh <<EOF
#!/bin/sh
export AUTOCONF="autoconf"
export AUTOHEADER="autoheader"
export AUTOM4TE="autom4te"
export AUTOMAKE="automake"
export ACLOCAL="aclocal"
export WHICH="which"
EOF
	fi
	for x in Makefile.cvs admin/Makefile.common; do
	if [[ -f "$x" && -z "$makefile" ]]; then makefile="$x"; fi
		done
		if [[ -f "$makefile" ]]; then
			debug-print "$FUNCNAME: configure: generating configure script, running make -f $makefile"
			emake -j1 -f $makefile
		fi
	[[ -f "./configure" ]] || die "no configure script found, generation unsuccessful"

	elibtoolize
# eapi2 eclass workaround end
}

src_configure() {
	local myconf

	# workaround kdeprefix mess
	myconf="${myconf} \
		--prefix=/usr/kde/3.5 \
		--mandir=/usr/kde/3.5/share/man \
		--infodir=/usr/kde/3.5/share/info \
		--datadir=/usr/kde/3.5/share \
		--sysconfdir=/usr/kde/3.5/etc"

	myconf="${myconf} \
		--enable-aqbanking \
		--enable-gwenhywfar \
		--without-arts"

	econf ${myconf}
}

# eapi2 eclass workaround start
src_compile() {
	kde_src_compile make
}
# eapi2 eclass workaround end
