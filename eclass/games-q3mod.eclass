# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/games-q3mod.eclass,v 1.1 2003/07/02 13:08:32 vapier Exp $

inherit games

ECLASS=games-q3mod
INHERITED="$INHERITED $ECLASS"

EXPORT_FUNCTIONS src_install pkg_postinst

DESCRIPTION="Quake III - ${MOD_DESC}"

SLOT="0"
KEYWORDS="-* x86"
IUSE="opengl X dedicated"

DEPEND="app-arch/unzip"
RDEPEND="virtual/glibc
	app-games/quake3
	dedicated? ( app-misc/screen )
	opengl? ( virtual/opengl )
	X? ( virtual/x11 )"

S=${WORKDIR}

games-q3mod_src_install() {
	[ -z "${MOD_NAME}" ] && die "what is the name of this q3mod ?"

	local bdir=${GAMES_PREFIX_OPT}/quake3
	local mdir=${bdir}/${MOD_NAME}
	MOD_BINS=${MOD_BINS:-${MOD_NAME}}

	if [ -d ${MOD_NAME} ] ; then
		dodir ${bdir}
		mv ${MOD_NAME} ${D}/${bdir}/
	fi
	if [ ! -z "`ls ${S}/* 2> /dev/null`" ] ; then
		dodir ${mdir}
		mv ${S}/* ${D}/${mdir}/
	fi

	games-q3mod_make_q3ded_exec
	newgamesbin ${T}/q3ded-${MOD_NAME}.bin q3ded-${MOD_BINS}
	games-q3mod_make_quake3_exec
	newgamesbin ${T}/quake3-${MOD_NAME}.bin quake3-${MOD_BINS}

	games-q3mod_make_init.d
	exeinto /etc/init.d
	newexe ${T}/q3ded-${MOD_NAME}.init.d q3ded-${MOD_BINS}
	games-q3mod_make_conf.d
	insinto /etc/conf.d
	newins ${T}/q3ded-${MOD_NAME}.conf.d q3ded-${MOD_BINS}

	dodir ${GAMES_SYSCONFDIR}/quake3

	prepgamesdirs
	chmod g+rw ${D}/${mdir}
	chmod -R g+rw ${D}/${GAMES_SYSCONFDIR}/quake3
}

games-q3mod_pkg_postinst() {
	local samplecfg=${FILESDIR}/server.cfg
	local realcfg=${GAMES_PREFIX_OPT}/quake3/${MOD_NAME}/server.cfg
	if [ -e ${samplecfg} ] && [ ! -e ${realcfg} ] ; then
		cp ${samplecfg} ${realcfg}
	fi
	return 0
}

games-q3mod_make_q3ded_exec() {
cat << EOF > ${T}/q3ded-${MOD_NAME}.bin
#!/bin/sh
exec q3ded +set fs_game ${MOD_NAME} +set dedicated 1 +exec server.cfg \${@}
EOF
}

games-q3mod_make_quake3_exec() {
cat << EOF > ${T}/quake3-${MOD_NAME}.bin
#!/bin/sh
exec quake3 +set fs_game ${MOD_NAME} \${@}
EOF
}

games-q3mod_make_init.d() {
cat << EOF > ${T}/q3ded-${MOD_NAME}.init.d
$(<${PORTDIR}/header.txt)

depend() {
	need net
}

start() {
	ebegin "Starting ${MOD_NAME} dedicated"
	screen -A -m -d -S ${MOD_NAME} su - ${GAMES_USER_DED} -c ${GAMES_BINDIR}/q3ded-${MOD_NAME} \${${MOD_NAME}_OPTS}
	eend \$?
}

stop() {
	ebegin "Stopping ${MOD_NAME} dedicated"
	kill \`screen -list | grep ${MOD_NAME} | awk -F . '{ print $1 }' | sed -e s/.//\`
	eend \$?
}
EOF
}

games-q3mod_make_conf.d() {
	if [ -e ${FILESDIR}/${MOD_NAME}.conf.d ] ; then
		cp ${FILESDIR}/${MOD_NAME}.conf.d ${T}/q3ded-${MOD_NAME}.conf.d
		return 0
	fi
cat << EOF > ${T}/q3ded-${MOD_NAME}.conf.d
$(<${PORTDIR}/header.txt)

# Any extra options you want to pass to the dedicated server
${MOD_NAME}_OPTS="+set vm_game 0 +set sv_pure 1 +set bot_enable 0 +set com_hunkmegs 24 +set net_port 27960"
EOF
}
