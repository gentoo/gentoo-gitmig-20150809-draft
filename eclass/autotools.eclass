# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Martin Schlemmer <azarah@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/eclass/autotools.eclass,v 1.4 2002/07/26 21:50:14 danarmak Exp $
# The autotools eclass enables building of the apps that needs the latest autconf/automake.
#
# NOTES:
#
#    This eclass was made to bridge the incompadibility problem of autoconf-2.13,
#    autoconf-2.5x and automake-1.4x, automake-1.5x.  Most packages needs
#    autoconf-2.13 and automake-1.4x, but cannot work with the latest versions
#    of these packages due to incompadibility, thus when we have a package that
#    needs the latest versions of automake and autoconf, it begins to get a
#    problem.
#
#
# Commented Example:
#
#    The following is a commented template for how to use this eclass:
#
#    #<cut here>
#    # Copyright 1999-2002 Gentoo Technologies, Inc.
#    # Distributed under the terms of the GNU General Public License, v2 or later
#    # Maintainer:  John Doe <john@foo.com>
#    # $Header: /var/cvsroot/gentoo-x86/eclass/autotools.eclass,v 1.4 2002/07/26 21:50:14 danarmak Exp $
#
#    # If you need to set the versions different from in here, it *must*
#    # be done before inherit.eclass is sourced
#    #ACONFVER=2.52f
#    #AMAKEVER=1.5b
#
#    # Source inherit.eclass and inherit AutoTools
#    . /usr/portage/eclass/inherit.eclass 
#    inherit autotools 
#
#    # This is pretty standard.
#    S=${WORKDIR}/${P}
#    DESCRIPTION="My Application"
#
#    # Here you *NEED* to have $SRC_URI as a source url to include the automake
#    # and autoconf source tarballs
#    SRC_URI="${SRC_URI}
#             http://download.foo.com/files/${P}.tar.gz"
#
#    HOMEPAGE="http://www.foo.com/"
#
#    # Here you *NEED* to have "$DEPEND" as an depend to include the dependancies
#    # of automake and autoconf.
#    DEPEND="${DEPEND}
#            foo-libs/libfoo"
#
#    src_compile() {
#
#        # This will install automake and autoconf in a tempory directory and
#        # setup the environment. Do not forget!!!!!!!
#        install_autotools
#
#        # Now like normal
#        ./configure --host=${CHOST} \
#                    --prefix=/usr || die
#        emake || die
#    }
#
#    src_install() {
#
#        # Still pretty standard to how you would normally do it
#        make DESTDIR=${D} install || die
#        dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
#    }
#    #<cut here>
#


ECLASS=autotools
INHERITED="$INHERITED $ECLASS"

#[ -z "$ACONFVER" ] && ACONFVER=2.52f
#[ -z "$AMAKEVER" ] && AMAKEVER=1.5b
[ -z "$ACONFVER" ] && die "!!! You need to set \$ACONFVER *before* inheriting the eclass !!!"
[ -z "$AMAKEVER" ] && die "!!! You need to set \$AMAKEVER *before* inheriting the eclass !!!"

DESCRIPTION="Based on the $ECLASS eclass"
#ASRC_URI="ftp://ftp.gnu.org/gnu/autoconf/autoconf-${ACONFVER}.tar.bz2
#	ftp://alpha.gnu.org/gnu/autoconf/autoconf-${ACONFVER}.tar.bz2
#	ftp://ftp.gnu.org/gnu/automake/automake-${AMAKEVER}.tar.bz2
#	ftp://alpha.gnu.org/gnu/automake/automake-${AMAKEVER}.tar.bz2"
SRC_URI="ftp://ftp.gnu.org/gnu/autoconf/autoconf-${ACONFVER}.tar.bz2
	ftp://alpha.gnu.org/gnu/autoconf/autoconf-${ACONFVER}.tar.bz2
	ftp://ftp.gnu.org/gnu/automake/automake-${AMAKEVER}.tar.bz2
	ftp://alpha.gnu.org/gnu/automake/automake-${AMAKEVER}.tar.bz2"
	
DEPEND="sys-devel/make
	sys-devel/perl
	>=sys-devel/m4-1.4o-r2"


AUTO_S="${WORKDIR}"
AUTO_D="${T}/autotools"

fetch_autotools() {

	local y
	for y in ${ASRC_URI} 
	do
		if [ ! -e ${DISTDIR}/${y##*/} ]
		then
			echo ">>> Fetching ${y##*/}..."
			echo
			local x
			local _SRC_URI
			for x in ${GENTOO_MIRRORS}
			do
				_SRC_URI="${_SRC_URI} ${x}/distfiles/${y##*/}"
			done
			_SRC_URI="${_SRC_URI} `queryhost.sh "${SRC_URI}"`"
			for x in ${_SRC_URI}
			do
				if [ ! -e ${DISTDIR}/${y##*/} ] 
				then
					if [ "${y##*/}" = "${x##*/}" ]
					then
						echo ">>> Trying site ${x}..."
						eval "${FETCHCOMMAND}"
					fi
				fi
			done
			if [ ! -e ${DISTDIR}/${y##*/} ]
			then
				echo '!!!'" Couldn't download ${y##*/} needed by autotools.eclass.  Aborting."
				exit 1
			fi
			echo
		fi      
	done
}

unpack_autotools() {

	cd ${AUTO_S}

	local x
	for x in ${ASRC_URI}
	do
		unpack ${x##*/} || die "!!! Could not unpack ${x##*/} needed by autotools !!!"
	done
}

install_autoconf() {

	cd ${AUTO_S}/autoconf-${ACONFVER} || die "!!! Failed to build autoconf !!!"

	 ./configure --prefix=${AUTO_D} \
	 	--infodir=${AUTO_D}/share/info \
		--mandir=${AUTO_D}/share/man \
		--target=${CHOST} || die "!!! Failed to configure autoconf !!!"

	emake || die "!!! Failed to build autoconf !!!"

	make install || die "!!! Failed to install autoconf !!!"
}

install_automake() {

	cd ${AUTO_S}/automake-${AMAKEVER} || die "!!! Failed to build automake !!!"

         ./configure --prefix=${AUTO_D} \
                --infodir=${AUTO_D}/share/info \
                --mandir=${AUTO_D}/share/man \
                --target=${CHOST} || die "!!! Failed to configure automake !!!"

        emake || die "!!! Failed to build automake !!!"

        make install || die "!!! Failed to install automake !!!"
}

install_autotools() {

	if [ "${SRC_URI/autoconf/}" = "$SRC_URI" ] || [ "${SRC_URI/automake/}" = "$SRC_URI" ]
	then
		echo "!!! \$SRC_URI was not set properly !!!  It needs to include \${SRC_URI}"
		exit 1
	fi

	if [ "${DEPEND/make/}" = "$DEPEND" ] || [ "${DEPEND/perl/}" = "$DEPEND" ] || \
		[ "${DEPEND/m4/}" = "$DEPEND" ]
	then
		echo "!!! \$DEPEND was not set properly !!!  It needs to include \${DEPEND}"
		exit 1
	fi

	mkdir -p ${AUTO_S}
	mkdir -p ${AUTO_D}/{bin,etc,lib,include,share} \
		|| die "!!! Could not create needed directories for autotools !!!"

#	fetch_autotools
#	unpack_autotools
	install_autoconf
	install_automake

	export PATH=${AUTO_D}/bin:${PATH}
	cd ${S}
	ln -sf ${AUTO_D}/share/automake/depcomp ${S}/depcomp
}

