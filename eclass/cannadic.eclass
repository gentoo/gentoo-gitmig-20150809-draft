# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/cannadic.eclass,v 1.3 2004/02/17 07:36:54 mr_bones_ Exp $
#
# Author: Mamoru KOMACHI <usata@gentoo.org>
#
# The cannadic eclass is used for installation and setup of Canna
# compatible dictionaries within the Portage system.
#

ECLASS=cannadic
INHERITED="$INHERITED $ECLASS"
EXPORT_FUNCTIONS cannadic-install dicsdir-install update-cannadic-dir \
	src_install pkg_setup pkg_postinst pkg_postrm

IUSE="${IUSE} canna"

DESCRIPTION="Based on the $ECLASS eclass"
HOMEPAGE="http://canna.sourceforge.jp/"		# you need to change this!
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="public-domain"
# I added all keywords form /usr/portage/profiles/keyword.desc atm since
# cannadic source is basically plain text and will run on any platform
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~mips ~hpps ~amd64"
SLOT="0"

S="${WORKDIR}"

DICSDIRFILE="$(echo ${FILESDIR}/*.dics.dir)"
CANNADICS="${CANNADICS}"			# (optional)
DOCS="README*"

# You don't need to modify these
#local cannadir dicsdir
cannadir="/var/lib/canna/dic/canna"
dicsdir="/var/lib/canna/dic/dics.d"

#
# pkg_setup() : sets up cannadic dir
pkg_setup() {

	keepdir $cannadir
	fowners bin:bin $cannadir
	fperms 0775 $cannadir
}

#
# cannadic-install() : installs dictionaries to cannadir
#
cannadic-install() {

	insinto $cannadir
	insopts -m0664 -o bin -g bin
	doins "$@"
}

#
# dicsdir-install() : installs dics.dir from ${FILESDIR}
#
dicsdir-install() {

	insinto ${dicsdir}
	doins ${DICSDIRFILE}
}

#
# src_install() : installs all dictionaries under ${WORKDIR}
#                 plus dics.dir and docs
#
src_install() {

	for f in *.c[btl]d *.t ; do
		cannadic-install $f
	done 2>/dev/null

	if [ -n "`use canna`" ] ; then
		dicsdir-install || die
	fi

	dodoc ${DOCS}
}

#
# update-cannadic-dir() : updates dics.dir for Canna Server,
#                         script for this part taken from Debian GNU/Linux
#
# compiles dics.dir files for Canna Server
# Copyright 2001 ISHIKAWA Mutsumi
# Licensed under the GNU General Public License, version 2.  See the file
# /usr/portage/license/GPL-2 or <http://www.gnu.org/copyleft/gpl.txt>.
update-cannadic-dir() {

	einfo
	einfo "Updating dics.dir for Canna ..."
	einfo

	# write new dics.dir file in case we are interrupted
	cat >${cannadir}/dics.dir.update-new<<-EOF
	# dics.dir -- automatically generated file by Portage.
	# DO NOT EDIT BY HAND.
	EOF

	for file in ${dicsdir}/*.dics.dir ; do
		echo "# $file" >> ${cannadir}/dics.dir.update-new
		cat $file >> ${cannadir}/dics.dir.update-new
		einfo "Added $file."
	done

	mv ${cannadir}/dics.dir.update-new ${cannadir}/dics.dir

	einfo
	einfo "Done."
	einfo
}

#
# pkg_postinst() : updates dics.dir and print out notice after install
#
pkg_postinst() {

	if [ -n "`use canna`" ] ; then
		update-cannadic-dir
		einfo
		einfo "Please restart cannaserver to fit changes."
		einfo "and modify your config file (~/.canna) to enable dictionary."

		if [ -n "${CANNADICS}" ] ; then
			einfo "e.g) add $(for d in ${CANNADICS}; do
				echo -n \"$d\"\ 
				done)to section use-dictionary()."
			einfo "For details, see documents under /usr/share/doc/${PF}"
		fi

		einfo
	fi
}

#
# pkg_postrm() : updates dics.dir and print out notice after uninstall
#
pkg_postrm() {

	if [ -n "`use canna`" ] ; then
		update-cannadic-dir
		einfo
		einfo "Please restart cannaserver to fit changes."
		einfo "and modify your config file (~/.canna) to disable dictionary."

		if [ -n "${CANNADICS}" ] ; then
			einfo "e.g) delete $(for d in ${CANNADICS}; do
				echo -n \"$d\"\  
				done)from section use-dictionary()."
		fi

		einfo
	fi
}
