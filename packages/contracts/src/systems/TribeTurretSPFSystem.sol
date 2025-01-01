// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import { console } from "forge-std/console.sol";
import { ResourceId } from "@latticexyz/world/src/WorldResourceId.sol";
import { WorldResourceIdLib } from "@latticexyz/world/src/WorldResourceId.sol";
import { IBaseWorld } from "@latticexyz/world/src/codegen/interfaces/IBaseWorld.sol";
import { System } from "@latticexyz/world/src/System.sol";
import { RESOURCE_SYSTEM } from "@latticexyz/world/src/worldResourceTypes.sol";
import { IBaseWorld } from "@eveworld/world/src/codegen/world/IWorld.sol";
import { Utils } from "./Utils.sol";
import { WORLD_ADDRESS } from "./constants.sol";
import { TargetPriority, Turret, SmartTurretTarget } from "@eveworld/world/src/modules/smart-turret/types.sol";

/**
 * @dev This contract is an example for implementing logic to a smart gate
 */
contract TribeTurretSPFSystem is System {
  /**
   * @dev a function to implement logic for smart turret based on proximity
   * @param smartTurretId The smart turret id
   * @param characterId is the owner of the smart turret
   * @param priorityQueue is the queue of existing targets ordered by priority, index 0 being the lowest priority
   * @param turret is the turret data
   * @param turretTarget is the target data
   */
  function inProximity(
    uint256 smartTurretId,
    uint256 characterId,
    TargetPriority[] memory priorityQueue,
    Turret memory turret,
    SmartTurretTarget memory turretTarget
  ) public returns (TargetPriority[] memory updatedPriorityQueue) {
    ResourceId systemId = Utils.smartTurretSystemId();

    return
      abi.decode(
        IBaseWorld(WORLD_ADDRESS).call(
          systemId,
          abi.encodeCall(this.inProximity, (smartTurretId, characterId, priorityQueue, turret, turretTarget))
        ),
        (TargetPriority[])
      );
  }

  /**
   * @dev a function to implement logic for smart turret based on aggression
   * @param smartTurretId The smart turret id
   * @param characterId is the owner of the smart turret
   * @param priorityQueue is the queue of existing targets ordered by priority, index 0 being the lowest priority
   * @param turret is the turret data
   * @param aggressor is the aggressor
   * @param victim is the victim
   */
  function aggression(
    uint256 smartTurretId,
    uint256 characterId,
    TargetPriority[] memory priorityQueue,
    Turret memory turret,
    SmartTurretTarget memory aggressor,
    SmartTurretTarget memory victim
  ) public returns (TargetPriority[] memory updatedPriorityQueue) {
    ResourceId systemId = Utils.smartTurretSystemId();

    return
      abi.decode(
        IBaseWorld(WORLD_ADDRESS).call(
          systemId,
          abi.encodeCall(this.aggression, (smartTurretId, characterId, priorityQueue, turret, aggressor, victim))
        ),
        (TargetPriority[])
      );
  }
}
