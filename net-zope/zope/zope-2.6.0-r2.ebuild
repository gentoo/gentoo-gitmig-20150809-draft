# Copyright 2002-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-zope/zope/zope-2.6.0-r2.ebuild,v 1.2 2003/09/07 00:21:34 msterret Exp $

S="${WORKDIR}/Zope-${PV}-src"

DESCRIPTION="Zope is a web application platform used for building high-performance, dynamic web sites."
HOMEPAGE="http://www.zope.org"
SRC_URI="http://www.zope.org/Products/Zope/${PV}/Zope-${PV}-src.tgz"
LICENSE="ZPL"
SLOT="0"

KEYWORDS="~x86 ~sparc"

RDEPEND="=dev-lang/python-2.1.3*"
DEPEND="virtual/glibc
		>=sys-apps/sed-4.0.5
		app-admin/zope-config
	   ${RDEPEND}"

ZUID=zope
ZGID=$(echo ${P} |sed -e "s:\.:_:g")
ZSERVDIR="${DESTTREE}/share/zope/${PF}/"
ZINSTDIR=$"/var/lib/zope/${ZGID}"
CONFDIR="/etc/conf.d/"

# Narrow the scope of ownership/permissions.
# Security plan:
# * ZUID is the superuser for all zope instances.
# * ZGID is for a single instance's administration.
# * Other's should not have any access to ${ZSERVDIR},
#   because they can work through the Zope web interface.
#   This should protect our code/data better.

#Parameters:
# $1 = instance directory
# $2 = group

setup_security()
{
    chown -R ${ZUID}:${2} ${1}
    chmod -R g+u ${1}
    chmod -R o-rwx ${1}
}

install_help()
{
	einfo "Need to setup an inituser (admin) before executing zope:"
	einfo "\tzope-config --zpasswd"
    einfo "To execute default Zope instance:"
	einfo "\t/etc/init.d/${ZGID} start"
}

pkg_setup() {
    if ! groupmod ${ZGID} > /dev/null 2>&1 ; then
		groupadd ${ZGID} || die "Can not add ${ZGID} group!"
    fi
    if ! id ${ZUID} > /dev/null 2>&1 ; then
		useradd -d ${ZSERVDIR} -c "Zope dedicatedr-user" ${ZUID} \
	|| die "Can not add ${ZUID} user!"
    fi
}

src_unpack()
{
	unpack ${A}
	# DateTime 2.6.0(only) rfc822 fix
	einfo "Applying patches..."
	bzcat ${FILESDIR}/${PV}/DateTime.py.bz2 \
		> ${S}/lib/python/DateTime/DateTime.py	|| die "Patch failed"
}

src_compile() {
    python2.1 wo_pcgi.py || die "Failed to compile."
}

src_install() {
	dodoc LICENSE.txt README.txt
	docinto doc ; dodoc doc/*.txt
	docinto doc/PLATFORMS ; dodoc doc/PLATFORMS/*
	docinto doc/changenotes ; dodoc doc/changenotes/*

    # using '/etc/init.d/zope'
	rm -Rf start stop LICENSE.txt README.txt doc/

	# Need to rip out the zinstance stuff out
    # but save as templates
	mkdir .templates
	mv -f Extensions/ .templates/
	mv -f import/ .templates/
	mv -f var/ .templates/

    # Add conf.d script.
    dodir /etc/conf.d
    echo "ZOPE_OPTS=\"-u zope\"" | \
    cat - ${FILESDIR}/${PV}/zope.envd > .templates/zope.confd

    # Fill in environmental variables
    sed -i -e "/ZOPE_HOME=/ c\\ZOPE_HOME=${ZSERVDIR}\\ " \
        -e "/SOFTWARE_HOME=/ c\\SOFTWARE_HOME=${ZSERVDIR}/lib/python\\ " \
	.templates/zope.confd

    # Add rc-script.
    cp ${FILESDIR}/${PV}/zope-r1.initd .templates/zope.initd

    # Copy the remaining contents of ${S} into the ${D}.
    dodir ${ZSERVDIR}
    cp -a . ${D}${ZSERVDIR}

	setup_security ${D}${ZSERVDIR} ${ZGID}
}

pkg_postinst()
{
	# Here we add our default zope instance.
	/usr/sbin/zope-config --zserv=${ZSERVDIR} --zinst=${ZINSTDIR} \
		--zgid=${ZGID}
	install_help
}

pkg_config()
{
	install_help
}
