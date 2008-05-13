# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gnucap/gnucap-0.35.20070221.ebuild,v 1.3 2008/05/13 07:17:17 calchan Exp $

inherit multilib

SNAPSHOTDATE="${P##*.}"
SNAPSHOT_DATE="${SNAPSHOTDATE:0:4}-${SNAPSHOTDATE:4:2}-${SNAPSHOTDATE:6:2}"

DESCRIPTION="GNUCap is the GNU Circuit Analysis Package"
SRC_URI="http://www.gnucap.org/devel/${PN}-${SNAPSHOT_DATE}.tar.gz
	http://www.gnucap.org/devel/${PN}-${SNAPSHOT_DATE}-bsim-models.tar.gz
	http://www.gnucap.org/devel/${PN}-${SNAPSHOT_DATE}-ngspice17-models.tar.gz
	http://www.gnucap.org/devel/${PN}-${SNAPSHOT_DATE}-spice3f5-models.tar.gz"
HOMEPAGE="http://www.gnucap.org/"

IUSE="doc examples"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="doc? ( virtual/latex-base )"

S="${WORKDIR}/${PN}-${SNAPSHOT_DATE}"

src_unpack() {
	unpack ${A} || die "Failed to unpack!"
	cd "${S}"

	# No need to install COPYING and INSTALL
	sed -i \
		-e 's: COPYING INSTALL::' \
		-e 's:COPYING history INSTALL:history:' \
		doc/Makefile.in || die "sed failed"

	if ! use doc ; then
		sed -i \
			-e 's:SUBDIRS = doc examples man:SUBDIRS = doc examples:' \
			Makefile.in || die "sed failed"
	fi

	if ! use examples ; then
		sed -i \
			-e 's:SUBDIRS = doc examples:SUBDIRS = doc:' \
			Makefile.in || die "sed failed"
	fi

	mv ../plugins .
	sed -i -e "s:CFLAGS = -O2 -g:CFLAGS +=:" \
		-e "s:CCFLAGS = \$(CFLAGS):CCFLAGS += \$(CFLAGS):" \
		plugins/*/Make2
}

src_compile () {
	econf --disable-dependency-tracking || die "Configuration failed"
	emake || die "Compilation failed"
	cd "${S}"/plugins
	for PLUGIN_DIR in * ; do
		cd "${S}"/plugins/${PLUGIN_DIR}
		emake || "Compilation failed"
	done
}

src_install () {
	emake DESTDIR="${D}" install || die "Installation failed"
	insopts -m0755
	cd "${S}"/plugins
	for PLUGIN_DIR in * ; do
		insinto /usr/$(get_libdir)/gnucap/${PLUGIN_DIR}
		cd "${S}"/plugins/${PLUGIN_DIR}
		for PLUGIN in */*.so ; do
			newins ${PLUGIN} ${PLUGIN##*/}
		done
	done
}
